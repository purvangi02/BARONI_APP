import 'package:baroni_app/auth_flow/PasswordresetSuccess.dart';
import 'package:baroni_app/uttils/app_assets.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:baroni_app/uttils/api_service.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPassword> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isUpdating = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isUpdating = true);

    try {
      final res = await ApiService.resetPassword(
        contact: widget.phoneNumber,
        newPassword: _passwordController.text,
      );
      if (res != null && res['success'] == true) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PasswordResetSuccess(),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res?['message'] ?? 'Failed to update password'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating password: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // background color
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon:  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Center(
                    child: Text(
                      "Baroni",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Subtitle
              const Center(
                child: Text(
                  "Create new password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 8),

               Center(
                child: Text(
                  "Reset your password in seconds and get\nback to your Baroni journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.grey6D),
                ),
              ),
              const SizedBox(height: 30),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "New Password",
                  prefixIcon: Image.asset(AppAssets.lockIcon,scale: 4,),
                  suffixIcon: IconButton(
                    icon: Image.asset(!_isPasswordVisible ?AppAssets.eyeOffIcon : AppAssets.eyeOnIcon,scale: 4,),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
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
                ),
              ),
              const SizedBox(height: 20),

              // Confirm password field
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Confirm New Password",
                  prefixIcon: Image.asset(AppAssets.lockIcon,scale: 4,),
                  suffixIcon: IconButton(
                    icon: Image.asset(!_isConfirmPasswordVisible ?AppAssets.eyeOffIcon : AppAssets.eyeOnIcon,scale: 4,),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                ),
              ),
              const Spacer(),

              // Update password button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isUpdating ? null : _updatePassword,
                  child: Text(
                    _isUpdating ? "Updating..." : "Update Password",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
