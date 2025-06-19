// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/show_snack_bar.dart';
import 'package:ai_tumor_detect/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_button.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_other_login.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/email_pass.dart';
import 'package:ai_tumor_detect/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150.w,
                    height: 130.h,
                  ),
                  SizedBox(height: 20.h),

                  // Welcome Text
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Login Title
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Email and Password Input Fields
                  EmailAndPass(
                    formKey: formKey,
                    onEmailChanged: (data) {
                      email = data;
                    },
                    onPasswordChanged: (data) {
                      password = data;
                    },
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: InkWell(
                        onTap: () {
                          // Handle "Forgot Password" functionality here
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16.sp,
                            fontFamily: GoogleFonts.aBeeZee().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Login Button
                  CustomButton(
                    text: 'Log in',
                    onPressed: () async {
                      final isValid = formKey.currentState?.validate() ?? false;

                      if (isValid) {
                        if (email != null && password != null) {
                          setState(() {
                            isLoading = true;
                          });

                          final result = await _authRepository.login(
                            email: email!,
                            password: password!,
                          );

                          result.fold(
                            (error) {
                              showSnackBar(
                                context,
                                error.toString(),
                                backgroundColor: Colors.red,
                              );
                            },
                            (user) {
                              showSnackBar(
                                context,
                                'You have successfully logged in.',
                                backgroundColor: Colors.green,
                              );
                              Navigator.pushReplacementNamed(
                                  context, '/homeScreen');
                            },
                          );
                        }
                      } else {
                        showSnackBar(
                          context,
                          'Please enter valid email and password.',
                          backgroundColor: Colors.red,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Or Continue With Text
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or Continue with',
                      style: TextStyle(
                        color: const Color(0xFF51526c),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.itim().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Social Login Options
                  const CustomOtherLogin(),
                  SizedBox(height: 20.h),

                  // Sign Up Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: const Color(0xFF51526c),
                          fontSize: 12.sp,
                          fontFamily: GoogleFonts.aBeeZee().fontFamily,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          ' Sign up',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 14.sp,
                            fontFamily: GoogleFonts.aBeeZee().fontFamily,
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
      ),
    );
  }
}
