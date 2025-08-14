import 'package:baroni_app/auth_flow/otp_verification/page/OtpPage.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:baroni_app/auth_flow/change_password/page/CreateNewPasswordPage.dart';

class ForgetPaaVerificationCodePage extends StatefulWidget {
  const ForgetPaaVerificationCodePage({super.key});

  @override
  State<ForgetPaaVerificationCodePage> createState() =>
      _ForgetPaaVerificationCodePageState();
}

class _ForgetPaaVerificationCodePageState
    extends State<ForgetPaaVerificationCodePage> {
  String countryCode = "+91";
  final TextEditingController _phoneController = TextEditingController();
  bool _isChecking = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your phone number'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isChecking = true);
    final fullPhone = "$countryCode${_phoneController.text.trim()}";

    try {
      // Check if phone number exists
      // final exists = await AuthService.instance.isPhoneNumberExists(fullPhone);

      // if (!exists) {
      //   if (!mounted) return;
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //           'Phone number not found! Please check your number or sign up.'),
      //       backgroundColor: Colors.red,
      //       duration: Duration(seconds: 4),
      //       behavior: SnackBarBehavior.floating,
      //     ),
      //   );
      //   return;
      // }

      // Phone number exists, start Firebase verification
      await AuthService.instance.verifyPhoneNumber(
        phoneNumber: fullPhone,
        onVerificationFailed: (e) {
          if (!mounted) return;
          setState(() => _isChecking = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${e.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        onVerificationCompleted: null,
        onCodeSent: (verificationId, resendToken) {
          if (!mounted) return;
          setState(() => _isChecking = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(
                verificationId: verificationId,
                phoneNumber: fullPhone,
                isFan: true,
                email: null,
                password: "",
                isPasswordReset: true,
                onOtpVerified: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewPassword(
                        phoneNumber: fullPhone,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        onCodeAutoRetrievalTimeout: () {
          setState(() => _isChecking = false);
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isChecking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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

              const SizedBox(height: 30),

              // Verification code heading
              const Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Info text
              const Center(
                child: Text(
                  "Enter your registered phone number to reset your password:",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Mobile number field
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  prefixIcon: CountryCodePicker(
                    onChanged: (code) {
                      setState(() {
                        countryCode = code.dialCode ?? "+91";
                      });
                    },
                    initialSelection: 'IN',
                    favorite: ['+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    padding: EdgeInsets.zero,
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400,
                      color: AppColors.grey6D
                  ),

                  // Normal border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),

                  // Border when focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintText: "Enter your mobile number",
                ),
                keyboardType: TextInputType.phone,
              ),

              const Spacer(),

              // Send code button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isChecking ? null : _sendCode,
                  child: Text(
                    _isChecking ? "Sending..." : "Send Code",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
