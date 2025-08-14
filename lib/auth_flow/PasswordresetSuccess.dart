import 'package:baroni_app/auth_flow/sign_in/page/signIn_page.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordResetSuccess extends StatelessWidget {
  const PasswordResetSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Baroni",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),

            // Middle content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Image or Icon
                    Container(
                      height: 150,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/image/passwordsuccess.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Your Password was\nsuccessfully Changed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                     Text(
                      "Your password has been changed successfully.\nYou can now log in securely.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey76,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()),
                    );
                  },
                  child: const Text(
                    "Back to Log in",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
