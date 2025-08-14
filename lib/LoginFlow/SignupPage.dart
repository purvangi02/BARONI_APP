import 'package:baroni_app/LoginFlow/PrivacypolicyPage.dart';
import 'package:baroni_app/LoginFlow/sign_in/page/signIn_page.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
  String countryCode = "+91";
  bool _isChecking = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _checkAndProceed() async {
    if (!agreeTerms) return;
    final raw = _phoneController.text.trim();
    if (raw.isEmpty) return;
    if (_passwordController.text.isEmpty) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isChecking = true);
    final fullPhone = "$countryCode$raw";

    try {
      // Check if phone number already exists
      final exists = await AuthService.instance.isPhoneNumberExists(fullPhone);

      if (exists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Phone number already registered! Please use a different number or sign in.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
        return;
      }

      // Phone number is unique, proceed to privacy policy
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrivacyPolicyPage(
            phoneNumber: fullPhone,
            isFan: isFan,
            email: _emailController.text.trim().isEmpty
                ? null
                : _emailController.text.trim(),
            password: _passwordController.text,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking phone number: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  color: const Color(0xffFBFBFB),
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
                children:  [
                  Text(
                    "Get Started ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  Text("•", style: TextStyle(color: AppColors.primaryColor, fontSize: 22)),
                ],
              ),
              const SizedBox(height: 20),

              // Phone number
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
                    // margin: EdgeInsets.zero,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400,
                      color: AppColors.grey6D
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
              const SizedBox(height: 15),

              // Email (Optional)
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400,
                      color: AppColors.grey6D
                  ),
                  // Border when focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintText: "Email Address (Optional)",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              // Password
              TextField(
                controller: _passwordController,
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400,
                      color: AppColors.grey6D
                  ),
                  // Border when focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextField(
                controller: _confirmPasswordController,
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
                  ),

                  hintStyle: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400,
                      color: AppColors.grey6D
                  ),
                  // Border when focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(
                      color: AppColors.greyF4, // Default border color
                      width: 1,
                    ),
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
                    // fillColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.06)),
                    overlayColor:
                    MaterialStateProperty.all<Color>(AppColors.primaryColor),
                    activeColor: AppColors.primaryColor,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(text: 'I agree to ', style: TextStyle(color: AppColors.blackColor,fontSize: 14,fontWeight: FontWeight.w500),),
                      TextSpan(text: 'The Terms of Service',style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )),
                      TextSpan(text: ' & ',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                      TextSpan(text: 'Privacy Policy',style: TextStyle(color: AppColors.primaryColor,fontSize: 14,fontWeight: FontWeight.w500)),
                    ]
                  )),
                  // const Expanded(
                  //   child: Text(
                  //     "I'm agree to The Terms of Service & Privacy Policy",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isChecking ? null : _checkAndProceed,
                  child: Text(
                    _isChecking ? "Checking..." : "Sign Up",
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1,color: AppColors.greyED,)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or"),
                  ),
                  Expanded(child: Divider(thickness: 1,color: AppColors.greyED,)),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninPage()),
                      );
                    },
                    child:  Text(
                      "Sign In",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
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
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: active ? Color(0xffFCEFF1) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: active ? Colors.white : Colors.transparent)
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
