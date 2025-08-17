import 'package:baroni_app/OnboardingScreen.dart';
import 'package:baroni_app/SpalashScreen.dart';
import 'package:baroni_app/auth_flow/sign_in/page/signIn_page.dart';
import 'package:baroni_app/uttils/bottom_bar.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // use General Sans
      theme: ThemeData(fontFamily: "General Sans",scaffoldBackgroundColor: Colors.white),

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
