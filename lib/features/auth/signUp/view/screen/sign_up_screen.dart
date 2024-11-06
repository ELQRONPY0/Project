import 'package:ai_tumor_detect/core/widgets/arrow_back.dart';
import 'package:ai_tumor_detect/core/widgets/custom_button.dart';
import 'package:ai_tumor_detect/core/widgets/custom_text_field.dart';
import 'package:ai_tumor_detect/features/auth/login/view/widget/custom_other_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    validator: (value) {},
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
                    validator: (value) {},
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
                    validator: (value) {},
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
                    validator: (value) {},
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
                    validator: (value) {},
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  SizedBox(height: 14.h),
                  CustomButton(text: 'Sign Up', onPressed: () {}),
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
