import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/widgets/custom_button.dart';
import 'package:ai_tumor_detect/features/auth/login/view/widget/custom_other_login.dart';
import 'package:ai_tumor_detect/features/auth/login/view/widget/email_pass.dart';
import 'package:ai_tumor_detect/features/auth/signUp/view/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150.w,
                  height: 130.h,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.itim().fontFamily),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: GoogleFonts.itim().fontFamily,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                const EmailAndPass(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.itim().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomButton(
                  text: 'Log in',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('Or Continue with',
                      style: TextStyle(
                        color: const Color(0xFF51526c),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.itim().fontFamily,
                      )),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const CustomOtherLogin(),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: const Color(0xFF51526c),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.itim().fontFamily,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        ' Sign up',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.itim().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
