from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import ml_model_0607

app = Flask(__name__)
CORS(app, support_credentials=True)

@app.route('/')
@cross_origin(supports_credentials=True)
def hello_world():
  return jsonify(message={'pain': 1}, status=200, mimetype='application/json')

@app.route('/ml', methods = ['POST'])
@cross_origin(supports_credentials=True)
def ml():
  gender = None
  features = None
  y_name = None
  if request.is_json:
      data = request.get_json()
      gender = data.get('gender')
      features = data.get('features', [])
      y_name = data.get('yName')
  else:
      return jsonify(content={'error': 'Invalid json'}), 400
  
  if gender is None:
     return jsonify(content={'error': 'Invalid Gender'}), 401
  
  if y_name is None:
    return jsonify(content={'error': 'Invalid Y Name'}), 401

  if features is None:
     return jsonify(content={'error': 'Missing features'}), 401
  
  best_formula, best_formula_features = ml_model_0607.hoho(gender=gender, provided_features=features, y_name=y_name)
  return jsonify(content={'formula': best_formula, 'features': best_formula_features}, status=200, mimetype='application/json'), 200

# @app.route('/user', methods = ['GET'])
# def ml():
#   x = ml_model_0607.hoho()
#   return jsonify({'status': 200, 'type': 'success', 'content': x})

if __name__ == '__main__':
    app.run(debug=True)