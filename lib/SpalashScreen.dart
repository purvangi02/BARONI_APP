import 'package:baroni_app/OnboardingScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 30 seconds, then navigate
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const OnboardingScreen()), // Change to your page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Text(
        'Baroni',
        style: TextStyle(
          color: Color.fromRGBO(236, 34, 11, 1), // exact rgba from Figma
          fontSize: 50, // Size from Figma
          fontWeight: FontWeight.w600, // 600 = SemiBold
          height: 36 / 50, // lineHeight / fontSize = 0.72
          letterSpacing: 0, // no extra spacing
          fontFamily: 'General Sans', // make sure you have it in pubspec.yaml
        ),
        textAlign: TextAlign.center, // Horizontal alignment: Center
      )),
    );
  }
}
