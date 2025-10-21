from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
import joblib
import numpy as np

app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'your_username'
app.config['MYSQL_PASSWORD'] = 'your_password'
app.config['MYSQL_DB'] = 'mental_health'

mysql = MySQL(app)

# Load the trained model
model = joblib.load('mth.pkl')  # Adjust the path as necessary

# Routes for user registration, login, and quiz submission

# 1. User Registration
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    location = data.get('location')
    
    hashed_password = generate_password_hash(password, method='sha256')

    cursor = mysql.connection.cursor()
    cursor.execute('INSERT INTO Users (username, password, location) VALUES (%s, %s, %s)', 
                   (username, hashed_password, location))
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'User registered successfully'}), 201

# 2. User Login
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    cursor = mysql.connection.cursor()
    cursor.execute('SELECT password FROM Users WHERE username = %s', [username])
    user = cursor.fetchone()
    cursor.close()

    if user and check_password_hash(user[0], password):
        return jsonify({'message': 'Login successful'}), 200
    else:
        return jsonify({'message': 'Invalid username or password'}), 401

# 3. Quiz Submission
@app.route('/submit_quiz', methods=['POST'])
def submit_quiz():
    data = request.get_json()
    username = data.get('username')
    total_score = data.get('total_score')
    result = data.get('result')

    cursor = mysql.connection.cursor()
    cursor.execute('INSERT INTO QuizResults (username, total_score, result) VALUES (%s, %s, %s)', 
                   (username, total_score, result))
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Quiz results received successfully'}), 201


# Routes for ML model prediction

# 4. Welcome route
@app.route('/')
def welcome():
    return 'Backend is working'

# 5. Prediction route
@app.route('/predict', methods=['POST'])
def predict():
    # Get data from the request
    data = request.json  # Expecting JSON input
    input_data = np.array(data['input']).reshape(1, -1)  # Reshape as necessary

    # Make prediction
    prediction = model.predict(input_data)
    
    return jsonify({'prediction': prediction.tolist()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
