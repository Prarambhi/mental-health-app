# mental-health-app
A cross-platform mental health app built with Flutter and MongoDB. It offers mood tracking, journaling, and guided wellness tools to support emotional well-being. Designed for a smooth user experience with secure data storage and modern UI.
Sure Pragati 😊
Here’s a **well-structured and professional README.md** file for your **Mental Health Tracker App** project.
It’s written in a clear and industry-ready format so you can directly put it in your GitHub repository or project submission.

---

# 🧠 Mental Health Tracker using Machine Learning

## 📋 Project Overview

The **Mental Health Tracker App** is a Flutter-based mobile application that helps users assess their mental well-being through an interactive quiz and mood-tracking interface.
It leverages a **Random Forest Machine Learning Model** integrated with a **Flask backend** and **MySQL database** to predict the user’s mental health condition and provide personalized recommendations.

The app aims to **increase awareness**, **encourage early detection**, and **connect users with professional help** if needed.

---

## 🎯 Objectives

* To predict a user’s **mental health status** based on quiz responses using machine learning.
* To help users **track mood trends** over time.
* To provide **mental wellness recommendations** and connect with **therapists** for appointments.
* To build a **user-friendly and responsive Flutter app** integrated with a **Flask backend**.

---

## 🧩 System Architecture

### 1. **Frontend (Flutter)**

* Built with Flutter for cross-platform compatibility.
* Screens include:

  * Splash Screen
  * Login / Signup Page
  * Home Page (with quiz and mood tracker)
  * Result Page (showing prediction and recommendations)

### 2. **Backend (Flask)**

* Acts as an API service between Flutter and the ML model.
* Handles requests, processes input, and returns predictions.

### 3. **Database (MySQL)**

* Stores user details, quiz responses, and mood records.
* Enables secure authentication and history tracking.

### 4. **Machine Learning (Random Forest)**

* Trained on mental health survey datasets.
* Predicts whether the user’s mental health condition is **Healthy**, **Mild**, or **Critical**.

---

## ⚙️ Tech Stack

| Component           | Technology Used         |
| ------------------- | ----------------------- |
| **Frontend**        | Flutter (Dart)          |
| **Backend**         | Flask (Python)          |
| **Database**        | MySQL                   |
| **ML Model**        | Random Forest           |
| **IDE**             | Android Studio, VS Code |
| **Version Control** | Git & GitHub            |

---

## 🧠 Features

* 🧩 **Interactive Quiz** – To assess user’s mental health status.
* 📊 **Mood Tracker** – Users can record their daily mood.
* 🧾 **Personalized Recommendations** – Based on ML prediction results.
* 👩‍⚕️ **Therapist Booking Option** – Users can schedule appointments.
* 🔐 **User Authentication** – Secure login and signup using MySQL.
* 💡 **User Dashboard** – Displays name, progress, and mental status insights.

---

## 🧰 Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/mental-health-tracker.git
cd mental-health-tracker
```

### 2. Backend Setup

```bash
cd backend
pip install -r requirements.txt
python app.py
```

### 3. Database Setup

* Install MySQL
* Create a database named `mental_health_db`
* Import the SQL schema provided in `database.sql`

### 4. Flutter Setup

```bash
cd flutter_app
flutter pub get
flutter run
```

### 5. Connect Backend and Frontend

* In your Flutter app, update the Flask API URL in `api_service.dart` with your local server IP.

---

## 🧪 Machine Learning Model

* The dataset used includes various mental health-related parameters such as stress level, sleep quality, and work-life balance.
* The Random Forest model achieved **high accuracy** in classifying users’ mental health.
* The trained model (`model.pkl`) is integrated into Flask to serve predictions.

---

## 📈 Future Enhancements

* Integration of **real-time sentiment analysis** using user text input.
* Addition of **chatbot support** for guided conversation.
* Use of **cloud-based database (Firebase or AWS)** for scalability.
* Advanced analytics dashboard to show **mood trends over time**.

---

## 🧑‍💻 Team Members

| Name            | Role                               | Responsibility                |
| --------------- | ---------------------------------- | ----------------------------- |
| Pragati Kharose | Flutter Developer & ML Integration | Frontend UI, Flask connection |
| [Teammate 2]    | Backend Developer                  | Flask API, MySQL database     |
| [Teammate 3]    | ML Engineer                        | Model training & evaluation   |
| [Teammate 4]    | Research & Documentation           | Literature survey, reports    |

---

## 📚 References

* Mental Health Dataset from Kaggle
* Flutter Documentation – [https://flutter.dev](https://flutter.dev)
* Flask Documentation – [https://flask.palletsprojects.com](https://flask.palletsprojects.com)
* Scikit-learn Library – [https://scikit-learn.org](https://scikit-learn.org)



## 💬 Acknowledgment

Special thanks to **Xavier Institute of Engineering (XIE)** and our faculty mentors for their continuous guidance and support throughout the development of this project.

---

Would you like me to **customize this README** with your actual teammates’ names and GitHub links, or make it look more **academic (for submission)** or **industry-style (for portfolio/GitHub)**?
