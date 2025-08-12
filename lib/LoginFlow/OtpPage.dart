import 'dart:async';

import 'package:baroni_app/LoginFlow/complete_profile_page.dart';
import 'package:baroni_app/LoginFlow/CreateNewPasswordPage.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.isFan,
      this.email,
      required this.password,
      this.isPasswordReset = false});

  final String verificationId;
  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;
  final bool isPasswordReset;

  @override
  State<OtpPage> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<OtpPage> {
  int _secondsRemaining = 20;
  late Timer _timer;
  String _smsCode = '';
  bool _submitting = false;

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

  Future<void> _onContinue() async {
    if (_smsCode.length < 6) return;
    setState(() => _submitting = true);

    try {
      if (widget.isPasswordReset) {
        // For password reset, just verify OTP and proceed
        if (_smsCode == "1234") {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewPassword(
                phoneNumber: widget.phoneNumber,
              ),
            ),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid code. Please enter 1234.')),
          );
        }
      } else {
        // For signup, verify with Firebase
        if (widget.verificationId == "auto") {
          // Auto-verification case, proceed to profile
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteProfilePage(
                phoneNumber: widget.phoneNumber,
                isFan: widget.isFan,
                email: widget.email,
                password: widget.password,
              ),
            ),
          );
        } else {
          // Manual verification with Firebase
          final userCred = await AuthService.instance.signInWithSmsCode(
            verificationId: widget.verificationId,
            smsCode: _smsCode,
          );

          // Save user profile
          await AuthService.instance.saveUserProfile({
            'uid': userCred.user!.uid,
            'phoneNumber': widget.phoneNumber,
            'email': widget.email,
            'password': widget.password,
            'role': widget.isFan ? 'fan' : 'star',
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

          // if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteProfilePage(
                phoneNumber: widget.phoneNumber,
                isFan: widget.isFan,
                email: widget.email,
                password: widget.password,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
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
              Text(
                widget.isPasswordReset ? "Reset Password" : "Verify your phone",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isPasswordReset
                    ? "We've sent a verification code to reset your password:"
                    : "We've sent an activation code to your mobile number:",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                widget.phoneNumber,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (widget.isPasswordReset)
                const Text(
                  "Enter OTP: 1234",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              else
                const Text(
                  "Enter the 6-digit code sent to your phone",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              const SizedBox(height: 24),
              Pinput(
                length: widget.isPasswordReset ? 4 : 6,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                onChanged: (pin) => _smsCode = pin,
                onCompleted: (pin) => _smsCode = pin,
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
                  onPressed: _submitting ? null : _onContinue,
                  child: Text(
                    _submitting ? 'Verifying...' : "Continue",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
