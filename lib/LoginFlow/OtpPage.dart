import 'dart:async';

import 'package:baroni_app/LoginFlow/CreateNewPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<OtpPage> {
  int _secondsRemaining = 20;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onContinue() {
    // Navigate to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const CreateNewPassword()), // Replace with your screen
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // background color
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Center(
                    child: Text(
                      "Baroni",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Forgot your password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "We’ve sent an activation code to your mobile number:",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                "+ 23 64356 75678",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                onCompleted: (pin) {
                  // handle pin complete
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Send code again  00.${_secondsRemaining.toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.red),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _onContinue,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
