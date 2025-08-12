import 'package:baroni_app/LoginFlow/ForgetPassVerificationPage.dart';
import 'package:baroni_app/LoginFlow/SignupPage.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SigninPage> {
  bool isFan = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Baroni",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),

              // Fan / Star toggle
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

              // Welcome back
              Row(
                children: const [
                  Text(
                    "Welcome back ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("•", style: TextStyle(color: Colors.red, fontSize: 22)),
                ],
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 15),

              // Password field
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

              const SizedBox(height: 10),

              // Forget password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ForgetPaaVerificationCodePage()),
                    );
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Sign In button
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
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Or divider
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

              // Social login
              // Social login section with assets
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

              const Spacer(),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
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

  Widget socialIcon(String url) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.network(url, width: 25, height: 25),
    );
  }
}
