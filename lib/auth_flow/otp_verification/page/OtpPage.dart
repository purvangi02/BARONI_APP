import 'dart:async';

import 'package:baroni_app/auth_flow/change_password/page/CreateNewPasswordPage.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.isFan,
    this.email,
    required this.password,
    this.isPasswordReset = false,
    this.userId,
    required this.onOtpVerified,
  });

  final String verificationId;
  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;
  final bool isPasswordReset;
  final String? userId;
  final VoidCallback onOtpVerified;

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

        // For password reset, verify with Firebase
        final userCred = await AuthService.instance.signInWithSmsCode(
          verificationId: widget.verificationId,
          smsCode: _smsCode,
        );

        // Save user profile with password reset
        if(userCred.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateNewPassword(
                    phoneNumber: widget.phoneNumber,
                  ),
            ),
          );
        }

      } else {
        // For signup, verify with Firebase
        if (widget.verificationId == "auto") {
          // Auto-verification case, proceed to profile
          if (!mounted) return;
          widget.onOtpVerified();
          Navigator.pop(context);
        } else {
          // Manual verification with Firebase
          final userCred = await AuthService.instance.signInWithSmsCode(
            verificationId: widget.verificationId,
            smsCode: _smsCode,
          );

          // // Save user profile
          // await AuthService.instance.saveUserProfile({
          //   'uid': userCred.user!.uid,
          //   'phoneNumber': widget.phoneNumber,
          //   'email': widget.email,
          //   'password': widget.password,
          //   'role': widget.isFan ? 'fan' : 'star',
          //   'createdAt': FieldValue.serverTimestamp(),
          //   'updatedAt': FieldValue.serverTimestamp(),
          // });

          // if (!mounted) return;

          widget.onOtpVerified();
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle:  TextStyle(fontSize: 20, color: AppColors.primaryColor,fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.greyF5,

      ),
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                    width: 60,
                  ),
                  Center(
                    child: Text(
                      "Baroni",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                widget.isPasswordReset ? "Reset Password" : "Verify your phone",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isPasswordReset
                    ? "We've sent a verification code to reset your password:"
                    : "We've sent an activation code to your mobile number:",
                textAlign: TextAlign.center,
                style:  TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400,color: AppColors.grey6D, height: 1.5),
              ),
              const SizedBox(height: 4),
              Text(
                widget.phoneNumber,
                style:  TextStyle(
                    color: AppColors.primaryColor,fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 24),
              Pinput(
                length:  6,
                defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     border: Border.all(color: AppColors.primaryColor, width: 1),
                //   ),
                // ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                  ),
                ),
                showCursor: true,
                onChanged: (pin) => _smsCode = pin,
                onCompleted: (pin) => _smsCode = pin,
              ),
              const SizedBox(height: 16),
              Text(
                "Send code again  00.${_secondsRemaining.toString().padLeft(2, '0')}",
                style:  TextStyle(color: AppColors.primaryColor),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _submitting ? null : _onContinue,
                  child: Text(
                    _submitting ? 'Verifying...' : "Continue",
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
