import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split, RepeatedKFold
from sklearn.feature_selection import RFE
from sklearn.preprocessing import RobustScaler
from sklearn.metrics import r2_score, mean_absolute_error
import itertools

# Load the dataset
data = pd.read_csv('nam.csv')  

# Define the features and targets
features = ['R1T', 'R1D', 'R2T', 'R2D', 'R6T', 'R6D']
X = data[features]
y_R345T = data['R345T']

# Random state
random_state = 2024

# Feature selection with exactly 2 features
def feature_selection(X, y):
    selector = RFE(estimator=LinearRegression(), n_features_to_select=2)
    selector.fit(X, y)
    selected_features = X.columns[selector.get_support()]
    return X.loc[:, selected_features], selected_features

# Function to train and evaluate the model with KFold
def evaluate_model_with_kfold(X, y, selected_features, random_state):
    rkf = RepeatedKFold(n_splits=5, n_repeats=10, random_state=random_state)
    all_r2_scores = []
    all_mae_scores = []

    X_train, X_test, y_train, y_test = train_test_split(X[selected_features], y, test_size=0.2, random_state=random_state)
    
    scaler = RobustScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    best_formula_scaled = ""
    best_formula_unscaled = ""
    best_r2 = -np.inf
    
    for train_index, val_index in rkf.split(X_train_scaled):
        X_train_kf, X_val_kf = X_train_scaled[train_index], X_train_scaled[val_index]
        y_train_kf, y_val_kf = y_train.iloc[train_index], y_train.iloc[val_index]
        
        model = LinearRegression()
        model.fit(X_train_kf, y_train_kf)
        
        y_val_pred = model.predict(X_val_kf)
        r2_val = model.score(X_val_kf, y_val_kf)
        mae_val = mean_absolute_error(y_val_kf, y_val_pred)
        
        all_r2_scores.append(r2_val)
        all_mae_scores.append(mae_val)
        
        if r2_val > best_r2:
            best_r2 = r2_val
            coefficients = model.coef_
            intercept = model.intercept_
            terms_scaled = " + ".join(f"{coef:.4f}*{feat}" for coef, feat in zip(coefficients, selected_features))
            best_formula_scaled = f"{y_train.name} = {intercept:.4f} + {terms_scaled}"

            # Calculate unscaled coefficients
            scale_ = scaler.scale_
            center_ = scaler.center_
            unscaled_coefs = model.coef_ / scale_
            unscaled_intercept = model.intercept_ - np.sum((center_ * model.coef_) / scale_)
            best_formula_unscaled = f"{unscaled_intercept:.4f} + " + " + ".join([f"{coef:.4f}*{feature}" for coef, feature in zip(unscaled_coefs, selected_features)])
   
    average_r2 = np.mean(all_r2_scores)
    average_mae = np.mean(all_mae_scores)
    
    y_test_pred = model.predict(X_test_scaled)
    mae_test = mean_absolute_error(y_test, y_test_pred)
    r2_test = r2_score(y_test, y_test_pred)

    return {
        "Unscaled Formula": best_formula_unscaled,
        "Average R² (CV)": average_r2,
        "Average MAE (CV)": average_mae,
        "R² Score (Test Set)": r2_test,
        "MAE Score (Test Set)": mae_test,
        "Selected Features": selected_features.to_list()
    }

# Store all results
results_list = []

# Loop through all combinations of features, keeping at least 2
for r in range(2, len(features) + 1):  # r is the number of features to select
    for subset in itertools.combinations(features, r):
        subset = list(subset)  # Convert to list to pass to the function

        # Apply feature selection to exactly 2 features from the subset
        X_subset = X[subset]
        selected_X, selected_features = feature_selection(X_subset, y_R345T)
        
        # Evaluate the model
        results = evaluate_model_with_kfold(selected_X, y_R345T, selected_features, random_state)
        results['Input'] = subset
        results_list.append(results)

# Create a DataFrame to display the results
results_df = pd.DataFrame(results_list)

results_df.to_csv(r'result.csv', sep="\t", encoding='utf-8', index=False, header=True)
