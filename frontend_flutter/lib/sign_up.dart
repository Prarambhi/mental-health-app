import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON handling

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Variables to store user input
  String username = '';
  String password = '';
  String confirmPassword = '';

  // Function to handle registration
  Future<void> registerUser() async {
    // Backend API URL (replace with your backend URL)
    const String url = 'http://<your_flask_backend_url>/register';

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

    // Ensure context is still mounted before using it
    if (!mounted) return;

    if (response.statusCode == 200) {
      // Registration successful, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)),
      );
    } else {
      // Show error message if registration failed
      _showDialog("Registration Failed", "Error occurred during registration");
    }
  }

  // Function to show error dialogs
  void _showDialog(String title, String content) {
    // Ensure context is still mounted before using it
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
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
                "Sign Up",
                style: TextStyle(
                  fontSize: 35,
                  color: Color.fromRGBO(245, 245, 220, 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        inputStyle("Username", "Enter your username", (value) {
          setState(() {
            username = value;
          });
        }),
        inputStyle("Password", "Enter your password", (value) {
          setState(() {
            password = value;
          });
        }, obscureText: true),
        inputStyle("Confirm Password", "Confirm your password", (value) {
          setState(() {
            confirmPassword = value;
          });
        }, obscureText: true),
        const SizedBox(height: 20),
        Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 82, 36, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {
              if (password == confirmPassword) {
                registerUser();
              } else {
                // Show error message if passwords don't match
                _showDialog("Password Mismatch", "Passwords do not match");
              }
            },
            child: const Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 82, 36, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(221, 255, 252, 252),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
