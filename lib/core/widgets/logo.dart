import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/logo.png', width: 150.w, height: 120.h),
        SizedBox(height: 15.h),
        Text(
          'AI Tumor Detect',
          style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.itim().fontFamily),
        ),
      ],
    );
  }
}
