import 'package:baroni_app/OnboardingScreen.dart';
import 'package:baroni_app/uttils/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Scale animation (zoom effect)
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Check token and navigate accordingly
    checkTokenAndNavigate();
  }

  Future<void> checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    await Future.delayed(const Duration(seconds: 3));



    if (mounted) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const OnboardingScreen(),
      //   ),
      // );
      // If you want to navigate to a dashboard if token exists, do:
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BottomNavCustom()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const Text(
              'Baroni',
              style: TextStyle(
                color: Color.fromRGBO(236, 34, 11, 1), // exact rgba from Figma
                fontSize: 50, // Size from Figma
                fontWeight: FontWeight.w600, // 600 = SemiBold
                height: 36 / 50, // lineHeight / fontSize = 0.72
                letterSpacing: 0, // no extra spacing
                fontFamily: 'General Sans',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
