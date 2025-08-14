import 'package:baroni_app/LoginFlow/ForgetPassVerificationPage.dart';
import 'package:baroni_app/LoginFlow/SignupPage.dart';
import 'package:baroni_app/HomeFlow/FanView/Dashboard_Fanview.dart';
import 'package:baroni_app/services/auth_service.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baroni_app/LoginFlow/sign_in/bloc/sign_in_cubit.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SigninPage> {
  bool isFan = true;
  bool obscurePassword = true;
  bool _isSigningIn = false;
  String countryCode = "+91";

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SignInCubit _signInCubit;

  @override
  void initState() {
    super.initState();
    _signInCubit = SignInCubit();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _signInCubit.close();
    super.dispose();
  }

  void _signInWithBloc() {
    if (_phoneController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Color.fromRGBO(236, 34, 11, 1),
        ),
      );
      return;
    }
    // final fullPhone = "$countryCode${_phoneController.text.trim()}";
    final fullPhone = _phoneController.text.trim();
    _signInCubit.login(fullPhone, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _signInCubit,
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardFanview()),
              (route) => false,
            );
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
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
                    const SizedBox(height: 30),
                
                    // Fan / Star toggle
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                    ),
                    const SizedBox(height: 30),
                
                    // Welcome back
                    Row(
                      children: const [
                        Text(
                          "Welcome back ",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        Text("•", style: TextStyle(color: Colors.red, fontSize: 22)),
                      ],
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
                        hintStyle: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.w400,
                            color: AppColors.grey6D
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                
                    // Password field
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
                        hintText: "Password",
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
                        child:  Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 10),
                
                    // Sign In button
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        final isLoading = state is SignInLoading;
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isLoading ? null : _signInWithBloc,
                            child: Text(
                              isLoading ? "Signing In..." : "Sign In",
                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        );
                      },
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
                
SizedBox(height: 30,),
                
                    // Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("Don't have an account? ",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey6D
                        ),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()),
                            );
                          },
                          child:  Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontWeight: FontWeight.w600,fontSize: 14),
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
            color: active ? AppColors.primaryColor : AppColors.grey6D,
            fontWeight: FontWeight.w500,
            fontSize: 15
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
