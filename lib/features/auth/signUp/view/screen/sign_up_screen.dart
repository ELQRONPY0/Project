import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/app_regex.dart';
import 'package:ai_tumor_detect/core/widgets/arrow_back.dart';
import 'package:ai_tumor_detect/core/widgets/custom_button.dart';
import 'package:ai_tumor_detect/core/widgets/custom_text_field.dart';
import 'package:ai_tumor_detect/features/auth/login/view/widget/custom_other_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hasLowerCase = false;

  bool hasUpperCase = false;

  bool hasNumber = false;

  bool hasSpecialCharacter = false;

  bool hasMinLength = false;

  bool isPasswordObscureText = true;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController(); // تهيئة المتغير هنا
    passwordControllerListener();
  }

  void passwordControllerListener() {
    passwordController.addListener(() {
      final password = passwordController.text;
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(password);
        hasUpperCase = AppRegex.hasUpperCase(password);
        hasNumber = AppRegex.hasNumber(password);
        hasSpecialCharacter = AppRegex.hasSpecialCharacter(password);
        hasMinLength = AppRegex.hasMinLength(password);
      });
    });
  }

  @override
  void dispose() {
    passwordController
        .dispose(); // تأكد من التخلص من المتحكم عند التخلص من الودجت
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArrowBack(),
                      SizedBox(width: 16.w),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18.0.h,
                          horizontal: 36.0.w,
                        ),
                        child: Image.asset(
                          'assets/images/Signup.png',
                          width: 150.w,
                          height: 140.h,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    hintText: 'Your Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isPhoneNumberValid(value)) {
                        return 'Please enter a valid phone number';
                      }
                    },
                    hintText: 'Enter Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  CustomTextField(
                    onchange: (data) {},
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                    },
                    hintText: 'Enter Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isPasswordValid(value)) {
                        return 'Please enter a valid password';
                      }
                    },
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                    },
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  SizedBox(height: 14.h),
                  CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        var auth = FirebaseAuth.instance;
                        auth.createUserWithEmailAndPassword(
                            email: 'email', password: 'password');
                      }),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Or Continue with',
                        style: TextStyle(
                          color: const Color(0xFF51526c),
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.itim().fontFamily,
                        )),
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
}
