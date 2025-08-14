import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:baroni_app/HomeFlow/FanView/Dashboard_Fanview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bloc/complete_profile_cubit.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage(
      {Key? key,
      required this.phoneNumber,
      required this.isFan,
      this.email,
      required this.password})
      : super(key: key);

  final String phoneNumber;
  final bool isFan;
  final String? email;
  final String password;

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  String? selectedLanguage;
  String countryCode = '+91';
  String countryName = 'India';
  bool _isSaving = false;
  File? _profileImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
    _phoneController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pseudoController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  void _submitProfile() {
    context.read<CompleteProfileCubit>().submitProfile(
      name: _nameController.text.trim(),
      pseudo: _pseudoController.text.trim(),
      profilePic: _profileImage,
      preferredLanguage: selectedLanguage ?? '',
      country: countryName,
      email: _emailController.text.trim(),
      contact: _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteProfileCubit(),
      child: BlocListener<CompleteProfileCubit, CompleteProfileState>(
        listener: (context, state) {
          if (state is CompleteProfileLoading) {
            setState(() => _isSaving = true);
          } else if (state is CompleteProfileSuccess) {
            setState(() => _isSaving = false);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardFanview()),
                  (route) => false,
            );
          } else if (state is CompleteProfileFailure) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message),behavior: SnackBarBehavior.floating,),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  // App title
                   Text(
                    "Baroni",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                   Text(
                    "Complete Your Profile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),

                  // Profile Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? const Icon(Icons.camera_alt_outlined, size: 35, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Section Title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Info",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Name
                  _buildTextField("Name", _nameController),

                  const SizedBox(height: 12),

                  // Pseudo
                  _buildTextField("Pseudo", _pseudoController),

                  const SizedBox(height: 12),

                  // Email
                  _buildTextField("Email Address (Optional)", _emailController),

                  const SizedBox(height: 12),

                  // Phone
                  _buildTextField("Phone Number", _phoneController,
                      keyboardType: TextInputType.phone),

                  const SizedBox(height: 12),

                  // Preferred Language Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedLanguage,
                    decoration: _inputDecoration("Preferred Language"),
                    items: ["English", "Hindi", "French", "Spanish"]
                        .map((lang) => DropdownMenuItem(
                      value: lang,
                      child: Text(lang),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "This is not shown publicly",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Choose Country
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.flag_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CountryCodePicker(
                            onChanged: (code) {
                              setState(() {
                                countryCode = code.dialCode ?? '+91';
                                countryName = code.name ?? 'India';
                              });
                            },
                            initialSelection: 'IN',
                            favorite: ['+91', 'IN'],
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _isSaving ? null : _submitProfile,
                      child: Text(
                        _isSaving ? "Saving..." : "Save",
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(hint),
    );
  }

  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
