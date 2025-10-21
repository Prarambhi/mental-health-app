import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage
import 'package:http/http.dart' as http;
import 'dart:convert'; // For converting JSON data

class Login extends StatefulWidget {
  const Login({super.key}); // 

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variables to store user input
  String username = '';
  String password = '';

  // Function to handle login
  Future<void> loginUser() async {
    // Backend API URL (replace with your backend URL)
    const String url = 'http://<your_flask_backend_url>/login';

    // Send HTTP POST request to backend
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    // Check if the widget is still mounted before using context
    if (mounted) {
      if (response.statusCode == 200) {
        // Login successful, navigate to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(username: username)),
        );
      } else {
        // Show error message if login failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Login Failed"),
            content: const Text("Invalid username or password"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: content(),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        // Header section with logo and title
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(46, 82, 36, 1),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(80, 80),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  "assets/logo.png",
                  height: 180,
                  width: 180,
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 231, 230, 188),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        inputStyle("Username", "Enter your username", (value) {
          setState(() {
            username = value;
          });
        }),
        const SizedBox(height: 20),
        inputStyle("Password", "Enter your password", (value) {
          setState(() {
            password = value;
          });
        }, obscureText: true),
        const SizedBox(height: 60),
        Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 82, 36, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {
              loginUser();
            },
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Don't have an account?",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              TextSpan(
                text: " Register",
                style: const TextStyle(fontSize: 15, color: Colors.orangeAccent),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed("/register");
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget inputStyle(String title, String hintText, Function(String) onChanged, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 20, 10),
      child: Row(
        children: [
          Text("$title:", style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                obscureText: obscureText,
                onChanged: onChanged, // Capture user input
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
