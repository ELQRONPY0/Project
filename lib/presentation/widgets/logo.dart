import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // تحديد الأبعاد بناءً على حجم الوالد
        double width =
            (constraints.maxWidth * 0.6).clamp(100.0, 300.0); // عرض الشعار
        double height =
            (constraints.maxHeight * 0.3).clamp(80.0, 200.0); // ارتفاع الشعار
        double fontSize =
            (constraints.maxWidth * 0.07).clamp(16.0, 30.0); // حجم الخط

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الشعار
            Image.asset(
              'assets/images/logo.png',
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 15.h),
            // النص
            Text(
              'AI Tumor Detect',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.itim().fontFamily,
              ),
            ),
          ],
        );
      },
    );
  }
}
