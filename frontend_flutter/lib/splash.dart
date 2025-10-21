import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key}); // Correctly pass the key to the superclass

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255), 
      child: Center(
        child: Container(
          constraints:const BoxConstraints.expand(), 
          child: Image.asset(
            "assets/splash_page.png",
            fit: BoxFit.cover, 
          ),
        ),
      ),
    );
  }
}
