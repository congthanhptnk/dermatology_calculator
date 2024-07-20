#FeatureSelection RobustScaler TrainTestSplit RepeatedKFold_train UnscaledFormula TanakaJohnston_test
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split, RepeatedKFold
from sklearn.feature_selection import RFE
from sklearn.preprocessing import RobustScaler
from sklearn.metrics import r2_score, root_mean_squared_error
from pathlib import Path

# Load the dataset
THIS_FOLDER = Path(__file__).parent.resolve()


# Define the random state to use
random_state = 2024

#2024 81101 150943 970917


# Feature selection method that also returns selected feature names
def feature_selection(X, y):
    selector = RFE(estimator=LinearRegression(), n_features_to_select=2)
    selector.fit(X, y)
    selected_features = X.columns[selector.get_support()]
    return X.loc[:, selected_features], selected_features

# Function to train and evaluate the model with KFold
def evaluate_model_with_kfold(X, y, random_state):
    rkf = RepeatedKFold(n_splits=5, n_repeats=10, random_state=random_state)
    all_r2_scores = []
    all_rmse_scores = []

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=random_state)
    
    scaler = RobustScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    X_train_selected, selected_features = feature_selection(X_train, y_train)

    selected_indices = [X_train.columns.get_loc(c) for c in selected_features]

    best_formula_scaled = ""
    best_formula_unscaled = ""
    best_formula_features = []
    best_r2 = -np.inf
    
    for train_index, val_index in rkf.split(X_train_scaled):
        X_train_kf, X_val_kf = X_train_scaled[train_index][:, selected_indices], X_train_scaled[val_index][:, selected_indices]
        y_train_kf, y_val_kf = y_train.iloc[train_index], y_train.iloc[val_index]
        
        model = LinearRegression()
        model.fit(X_train_kf, y_train_kf)
        
        y_val_pred = model.predict(X_val_kf)
        r2_val = model.score(X_val_kf, y_val_kf)
        rmse_val = root_mean_squared_error(y_val_kf, y_val_pred)
        
        all_r2_scores.append(r2_val)
        all_rmse_scores.append(rmse_val)
        
        if r2_val > best_r2:
            best_r2 = r2_val
            coefficients = model.coef_
            intercept = model.intercept_
            terms_scaled = " + ".join(f"{coef}*{feat}" for coef, feat in zip(coefficients, selected_features))
            best_formula_features.clear()
            for coef, feat in zip(coefficients, selected_features):
                best_formula_features.append(feat)
            best_formula_scaled = f"{y_train.name} = {intercept} + {terms_scaled}"

            # Calculate unscaled coefficients
            scale_ = scaler.scale_[selected_indices]
            center_ = scaler.center_[selected_indices]
            unscaled_coefs = model.coef_ / scale_
            unscaled_intercept = model.intercept_ - np.sum((center_ * model.coef_) / scale_)
            best_formula_unscaled = f"{unscaled_intercept} + " + " + ".join([f"{coef}*{feature}" for coef, feature in zip(unscaled_coefs, selected_features)])
   
    
    average_r2 = np.mean(all_r2_scores)
    std_r2 = np.std(all_r2_scores)
    average_rmse = np.mean(all_rmse_scores)
    
    y_test_pred = model.predict(X_test_scaled[:, selected_indices])
    rmse_test = root_mean_squared_error(y_test, y_test_pred)
    r2_test = r2_score(y_test, y_test_pred)

# # Tanaka-Johnston test set
#     tanaka_constant = None
#     if y_train.name == "R345T":
#         tanaka_constant = 11
#     else:
#         tanaka_constant = 10.5
        
#     tanaka_test_pred = X_test['R1D'] + X_test['R2D'] + tanaka_constant
#     tanaka_r2 = r2_score(y_test, tanaka_test_pred)
#     tanaka_rmse = root_mean_squared_error(y_test, tanaka_test_pred)

# Print
    print(f'-----------{y_train.name}------------')
    print("Best Scaled Formula:", best_formula_scaled)
    print("Best Unscaled Formula:", best_formula_unscaled)
    print(f"Average R² (Cross-Validation): {average_r2:.4f} ± {std_r2:.4f}")
    print("Average RMSE (Cross-Validation):", average_rmse)
    print("R² Score (Test Set):", r2_test)
    print("RMSE Score (Test Set):", rmse_test)
    # print("Tanaka-Johnson R² Score (Test Set):", tanaka_r2)
    # print("Tanaka-Johnson RMSE Score (Test Set):", tanaka_rmse)
    print(" ")
    return best_formula_unscaled, best_formula_features

# Apply function for each target
# ['R1T', 'R1D', 'R2T', 'R2D', 'R6T', 'R6D']
def hoho(gender, provided_features, y_name ):
    myfile = THIS_FOLDER / "nu.csv"
    if gender == 'male':
        myfile = THIS_FOLDER / "nam.csv"
    data = pd.read_csv(myfile)  

    # Define the features and targets
    features = provided_features
    X = data[features]

    y_data =data['R345T']
    if y_name == 'R345D':
        y_data = data['R345D']
    best_formula, best_formula_features = evaluate_model_with_kfold(X, y_data, random_state)
    return best_formula, best_formula_features
# evaluate_model_with_kfold(X, y_R345T, random_state)
# evaluate_model_with_kfold(X, y_R345D, random_state)
