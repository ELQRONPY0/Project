import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class Supportbutton extends StatelessWidget {
  const Supportbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        iconColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        // Navigate to support page
      },
      icon: const Icon(Iconsax.support),
      label: Text("Need Help?",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ));
  }
}
