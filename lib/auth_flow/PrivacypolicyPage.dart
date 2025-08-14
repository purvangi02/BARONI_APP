import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage(
      {super.key,
      required this.phoneNumber,
      required this.isFan,
      this.email,
      required this.password,
      required this.userId});

  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;
  final String userId;

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
                      icon:  Icon(Icons.arrow_back_ios_new,size: 15, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                   Expanded(
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
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
                    children:  [
                      Text(
                        "My Website one of our main priorities is the privacy of our visitors. "
                        "This Privacy Policy document contains types of information that is collected and recorded by My Website and how we use it.\n",
                        style: TextStyle(
                            color: AppColors.grey76, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        "If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\n",
                        style: TextStyle(
                            color: AppColors.grey76, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        "This privacy policy applies only to our online activities and is valid for visitors to our website "
                        "with regards to the information that they shared and/or collect in My Website. This policy is not applicable "
                        "to any information collected offline or via channels other than this website. Consent\n"
                        "By using our website, you hereby consent to ",
                        style: TextStyle(
                            color: AppColors.grey76, fontSize: 14, height: 1.5),
                      ),
                    ],
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
