import 'package:baroni_app/auth_flow/complete_profile/page/complete_profile_page.dart';
import 'package:baroni_app/auth_flow/sign_in/page/signIn_page.dart';
import 'package:baroni_app/home/FanView/Dashboard_Fanview.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/api_service.dart';
import 'package:baroni_app/uttils/app_assets.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../bloc/sign_up_cubit.dart';
import 'package:baroni_app/auth_flow/otp_verification/page/OtpPage.dart';

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
  late SignUpCubit _signUpCubit;


  @override
  void initState() {
    super.initState();
    _signUpCubit = SignUpCubit();
  }

  @override
  void dispose() {
    _signUpCubit.close();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _sendOtpAndProceed() async {
    if (!agreeTerms) return;
    final raw = _phoneController.text.trim();
    if (raw.isEmpty) return;
    if (_passwordController.text.isEmpty) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'),behavior: SnackBarBehavior.floating,),
      );
      return;
    }
    final fullPhone = "$countryCode$raw";
    setState(() => _isChecking = true);

    var check = await ApiService.checkUser(keyName: 'contact',email: _phoneController.text.toString());

    if( check!['exists'] == true) {
      await AuthService.instance.verifyPhoneNumber(
        phoneNumber: fullPhone,
        onCodeSent: (verificationId, resendToken) {
          setState(() {
            _isChecking = false;
          });
          // Navigate to OTP verification screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpPage(
                    verificationId: verificationId,
                    phoneNumber: fullPhone,
                    isFan: isFan,
                    email: _emailController.text
                        .trim()
                        .isEmpty ? null : _emailController.text.trim(),
                    password: _passwordController.text,
                    isPasswordReset: false,
                    onOtpVerified: () {
                      // After OTP verified, call registration API
                      _signUpCubit.register(
                        contact: fullPhone,
                        password: _passwordController.text,
                        email: _emailController.text
                            .trim()
                            .isEmpty ? null : _emailController.text.trim(),
                      );
                    },
                  ),
            ),
          );
        },
        onVerificationFailed: (e) {
          setState(() => _isChecking = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP send failed: ${e.message}'),
              behavior: SnackBarBehavior.floating,),
          );
        },
        onVerificationCompleted: null,
        onCodeAutoRetrievalTimeout: () {
          setState(() => _isChecking = false);
        },
      );
    }else {
      setState(() => _isChecking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User already exists'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      // Get Google Sign In account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // user canceled

      // Step 2: Google auth tokens
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Step 3: Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        // accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Firebase sign-in
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 5: User details
      print("Firebase UID: ${userCredential.user?.uid}");
      print("Name: ${userCredential.user?.displayName}");
      print("Email: ${userCredential.user?.email}");
      print("Photo: ${userCredential.user?.photoURL}");

      var check = await ApiService.checkUser(keyName: 'email',email: userCredential.user!.email.toString());

      print('check user : ${check!['exists']}');

      if( check!['exists'] == true) {
      var login = await ApiService.login(userCredential.user!.email.toString(), '',false);
        if(login != null && login['success'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardFanview()),
          );
        } else {
          print("User login failed: ${login?['message']}");
        }

      }else{

        var register = await ApiService.register(
          contact: '',
          password: '',
          email: userCredential.user!.email.toString(),
        );

        if(register != null && register['success'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardFanview()),
          );
        } else {
          print("User registration failed: ${register?['message']}");
        }

      }




      // Step 6: Navigate to dashboard

    } catch (error) {
      print("Google Sign-In Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign-in failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _signUpCubit,
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CompleteProfilePage(
                  phoneNumber: "$countryCode${_phoneController.text.trim()}",
                  isFan: isFan,
                  email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
                  password: _passwordController.text,
                ),
              ),
            );
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Scaffold(
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
                      prefixIcon:  Image.asset(AppAssets.smsIcon,scale: 4,),
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
                      prefixIcon: Image.asset(AppAssets.lockIcon,scale: 4,),
                      suffixIcon: IconButton(
                        icon: Image.asset(obscurePassword ?AppAssets.eyeOffIcon : AppAssets.eyeOffIcon,scale: 4,),
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
                      prefixIcon: Image.asset(AppAssets.lockIcon,scale: 4,),
                      suffixIcon: IconButton(
                          icon: Image.asset(obscurePassword ?AppAssets.eyeOffIcon : AppAssets.eyeOffIcon,scale: 4,),
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
                  const SizedBox(height: 20),

                  // Terms and Conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align top so checkbox & text match
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.grey, // Border color when unchecked
                        ),
                        child: Checkbox(
                          visualDensity: VisualDensity.compact, // Removes default padding
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Less touch padding
                          value: agreeTerms,
                          overlayColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor,
                          ),
                          activeColor: AppColors.primaryColor, // Checked color
                          fillColor: MaterialStateProperty.all<Color>(
                            AppColors.blackColor.withOpacity(0.06), // Fill color when checked
                          ),
                          checkColor: AppColors.primaryColor,
                          focusColor: AppColors.grey6D,
                          hoverColor: AppColors.grey6D,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            color: Colors.transparent, // Border color when unchecked
                            width: 1,
                          ),
                          onChanged: (value) {
                            setState(() {
                              agreeTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded( // Ensures text wraps and avoids overflow
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I’m agree to The',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' Terms of Service',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' & ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        final isLoading = state is SignUpLoading || _isChecking;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: isLoading ? null : _sendOtpAndProceed,
                          child: Text(
                            isLoading ? "Checking..." : "Sign Up",
                            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        );
                      },
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
                            AppAssets.appleIcon,
                            height: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: _handleGoogleSignIn,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAssets.googleIcon,
                              height: 24,
                            ),
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
