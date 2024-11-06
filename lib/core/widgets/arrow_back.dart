import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(
            width: 0.5,
            color: AppColor.primaryColor,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
