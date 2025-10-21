import joblib
import numpy as np

# Load your trained model
model = joblib.load('mth.pkl')  # Use the correct filename

# Function to get user input and make predictions
def make_prediction():
    # Get input from the user
    input_values = input("Enter input values separated by commas: ")
    
    # Convert input string to a list of floats
    input_data = np.array([float(i) for i in input_values.split(',')]).reshape(1, -1)
    
    # Make prediction
    prediction = model.predict(input_data)
    
    # Output the prediction
    print(f'Prediction: {prediction[0]}')  # Assuming prediction is a single value or class

# Call the prediction function
make_prediction()
