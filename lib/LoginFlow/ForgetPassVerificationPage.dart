import 'package:baroni_app/LoginFlow/OtpPage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ForgetPaaVerificationCodePage extends StatelessWidget {
  const ForgetPaaVerificationCodePage({super.key});

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

              // Back button with background color

              // Title

              const SizedBox(height: 30),

              // Verification code heading
              const Center(
                child: Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Info text
              const Center(
                child: Text(
                  "We've sent an activation code to your mobile number:",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 5),

              // Phone number in red
              const Center(
                child: Text(
                  "+ 23 64356 75678",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Mobile number field
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      "https://flagcdn.com/w20/gb.png",
                      width: 20,
                    ),
                  ),
                  prefixText: "+44  ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpPage()),
                    );
                  },
                  child: const Text(
                    "Send a code",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
