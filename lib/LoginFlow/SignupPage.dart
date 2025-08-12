import 'package:baroni_app/LoginFlow/PrivacypolicyPage.dart';
import 'package:baroni_app/LoginFlow/SignInPage.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupPage> {
  bool isFan = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Title
              const Text(
                "Baroni",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),

              // Fan / Star Toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    toggleButton("Fan", isFan, () {
                      setState(() {
                        isFan = true;
                      });
                    }),
                    toggleButton("Star", !isFan, () {
                      setState(() {
                        isFan = false;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Get Started text
              Row(
                children: const [
                  Text(
                    "Get Started ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("•", style: TextStyle(color: Colors.red, fontSize: 22)),
                ],
              ),
              const SizedBox(height: 20),

              // Phone number
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
              const SizedBox(height: 15),

              // Email (Optional)
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Email Address (Optional)",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              // Password
              TextField(
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextField(
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Confirm Password",
                ),
              ),
              const SizedBox(height: 15),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "I'm agree to The ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: " & "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign Up Button
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
                    if (agreeTerms) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage()),
                      );
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),

              // Social buttons with assets
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/image/apple_icon.png",
                        height: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/image/google_icon.png",
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account? "),
                  GestureDetector(
                    onTap: () {
                      // Go to Sign In page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninPage()),
                      );
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
