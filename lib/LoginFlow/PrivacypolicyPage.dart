import 'package:baroni_app/LoginFlow/OtpPage.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage(
      {super.key,
      required this.phoneNumber,
      required this.isFan,
      this.email,
      required this.password});

  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              // Header Row
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
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
                    width: 50,
                  ),
                  const Expanded(
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "My Website one of our main priorities is the privacy of our visitors. "
                        "This Privacy Policy document contains types of information that is collected and recorded by My Website and how we use it.\n",
                        style: TextStyle(
                            color: Colors.black87, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        "If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\n",
                        style: TextStyle(
                            color: Colors.black87, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        "This privacy policy applies only to our online activities and is valid for visitors to our website "
                        "with regards to the information that they shared and/or collect in My Website. This policy is not applicable "
                        "to any information collected offline or via channels other than this website. Consent\n"
                        "By using our website, you hereby consent to ",
                        style: TextStyle(
                            color: Colors.black87, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),

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
                  onPressed: () async {
                    try {
                      // Start phone verification
                      await AuthService.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        onVerificationFailed: (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Verification failed: ${e.message}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        onVerificationCompleted: (cred) async {
                          try {
                            // Auto-verification completed
                            final userCred =
                                await AuthService.instance.createUserWithPhone(
                              verificationId: "auto",
                              smsCode: "auto",
                            );

                            // Save user profile
                            await AuthService.instance.saveUserProfile({
                              'uid': userCred.user!.uid,
                              'phoneNumber': phoneNumber,
                              'email': email,
                              'password': password,
                              'role': isFan ? 'fan' : 'star',
                              'createdAt': FieldValue.serverTimestamp(),
                              'updatedAt': FieldValue.serverTimestamp(),
                            });

                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpPage(
                                    verificationId: "auto",
                                    phoneNumber: phoneNumber,
                                    isFan: isFan,
                                    email: email,
                                    password: password,
                                  ),
                                ),
                              );
                            }
                          } catch (err) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Auto verification failed. Please enter the code manually.'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          }
                        },
                        onCodeSent: (verificationId, resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpPage(
                                verificationId: verificationId,
                                phoneNumber: phoneNumber,
                                isFan: isFan,
                                email: email,
                                password: password,
                              ),
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Sign Up",
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
