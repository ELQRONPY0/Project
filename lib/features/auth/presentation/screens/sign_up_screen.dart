// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/app_regex.dart';
import 'package:ai_tumor_detect/core/helper/show_snack_bar.dart';
import 'package:ai_tumor_detect/presentation/widgets/arrow_back.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_button.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_other_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    try {
      if (formKey.currentState!.validate()) {
        final name = nameController.text.trim();
        final phone = phoneController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final confirmPassword = confirmPasswordController.text.trim();

        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match!')),
          );
          return;
        }

        setState(() {
          isLoading = true;
        });

        try {
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          showSnackBar(
            context,
            'Registration has been completed successfully.',
            backgroundColor: Colors.green,
          );
          Navigator.pushReplacementNamed(context, '/homeScreen');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showSnackBar(context, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            showSnackBar(
              context,
              'The account already exists for that email.',
              backgroundColor: Colors.blue,
            );
          }
        } catch (e) {
          showSnackBar(
            context,
            'An error occurred while signing up',
            backgroundColor: Colors.red,
          );
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (error) {
      showSnackBar(
        context,
        'Unexpected error occurred during form validation.',
        backgroundColor: Colors.red,
      );
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const ArrowBack(),
                      const Spacer(
                        flex: 9,
                      ),
                      Image.asset(
                        'assets/images/Signup.png',
                        width: 150.w,
                        height: 140.h,
                      ),
                      const Spacer(
                        flex: 11,
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  _buildLabel('Your Name'),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextField(
                    controller: nameController,
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter your name'
                        : null,
                    hintText: 'Your Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  // SizedBox(height: 14.h),
                  // _buildLabel('Phone Number'),
                  // const SizedBox(
                  //   height: 6,
                  // ),
                  // CustomTextField(
                  //   controller: phoneController,
                  //   validator: (value) => (value?.isEmpty == true ||
                  //           !AppRegex.isPhoneNumberValid(value!))
                  //       ? 'Please enter a valid phone number'
                  //       : null,
                  //   hintText: 'Enter Phone Number',
                  //   prefixIcon: const Icon(Icons.phone),
                  // ),
                  SizedBox(height: 14.h),
                  _buildLabel('Email'),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextField(
                    controller: emailController,
                    validator: (value) => (value?.isEmpty == true ||
                            !AppRegex.isEmailValid(value!))
                        ? 'Please enter a valid email'
                        : null,
                    hintText: 'Enter Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 14.h),
                  _buildLabel('Password'),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    isObscureText: true, // إخفاء النص للحقل
                    validator: (value) => (value?.isEmpty == true ||
                            !AppRegex.isPasswordValid(value!))
                        ? 'Please enter a valid password'
                        : null,
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  SizedBox(height: 14.h),
                  _buildLabel('Confirm Password'),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    isObscureText: true, // إخفاء النص للحقل
                    validator: (value) => value?.isEmpty == true
                        ? 'Please confirm your password'
                        : null,
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: _signUp,
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or Continue with',
                      style: TextStyle(
                        color: const Color(0xFF51526c),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  const CustomOtherLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
    );
  }
}
