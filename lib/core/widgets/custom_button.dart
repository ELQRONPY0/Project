import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        onPressed: () {},
        color: AppColor.primaryColor,
        textColor: AppColor.white,
        padding: EdgeInsets.only(right: 50.w, left: 50.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.itim().fontFamily,
              color: AppColor.white,
            )),
      ),
    );
  }
}
