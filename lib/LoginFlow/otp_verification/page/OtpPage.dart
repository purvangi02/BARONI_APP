import 'dart:async';

import 'package:baroni_app/LoginFlow/complete_profile/page/complete_profile_page.dart';
import 'package:baroni_app/LoginFlow/CreateNewPasswordPage.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/otp_verification_cubit.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.isFan,
      this.email,
      required this.password,
      this.isPasswordReset = false,
      this.userId});

  final String verificationId;
  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;
  final bool isPasswordReset;
  final String? userId;

  @override
  State<OtpPage> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<OtpPage> {
  int _secondsRemaining = 20;
  late Timer _timer;
  String _smsCode = '';
  bool _submitting = false;
late OtpVerificationCubit _cubit;
  String? _accessToken; // Store accessToken if needed

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Optionally, retrieve accessToken from somewhere if needed
    // _loadAccessToken();
    _cubit = OtpVerificationCubit();

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
    _cubit.close(); // Close the cubit to free resources
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (_smsCode.length < 4) return;

    if (widget.userId != null && widget.userId!.isNotEmpty) {
      // Use Bloc for backend OTP verification
      // final cubit = context.read<OtpVerificationCubit>();
      _cubit.verifyOtp(
        userId: widget.userId!,
        otp: _smsCode,
        accessToken: _accessToken ?? '', // Provide token if required
      );
      return;
    }

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
      width: 64,
      height: 64,
      textStyle:  TextStyle(fontSize: 20, color: AppColors.primaryColor,fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.greyF5,

      ),
    );

    return BlocProvider(
      create: (_) => _cubit,
      child: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listener: (context, state) {
          if (state is OtpVerificationLoading) {
            setState(() => _submitting = true);
          } else if (state is OtpVerificationSuccess) {
            setState(() => _submitting = false);
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
          } else if (state is OtpVerificationFailure) {
            setState(() => _submitting = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
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
                    length:  4,
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
                      child: BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                        builder: (context, state) {
                          if (state is OtpVerificationLoading) {
                            return const Text(
                              'Verifying...',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            );
                          }
                          return const Text(
                            "Continue",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
