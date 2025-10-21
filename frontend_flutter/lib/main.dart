import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/quiz1.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:flutter_application_1/splash.dart';
import 'package:flutter_application_1/home_page.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const Splash(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        // HomePage will be passed username dynamically
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          String username;

          if (args is String) {
            username = args;
          } else {
            username = "John Doe"; // Default username if not passed
          }

          return HomePage(username: username);
        },
        '/quiz1': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          String username;

          if (args is String) {
            username = args;
          } else {
            username = "Guest"; // Default username for quiz
          }

          return Quiz1(username: username);
        },
      },
    );
  }
}
