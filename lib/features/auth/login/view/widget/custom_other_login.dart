import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtherLogin extends StatelessWidget {
  const CustomOtherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xffb2b2cc),
                width: 0.5.w,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/google_Icon.png"),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xffb2b2cc),
                        width: 0.5.w,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Container(
          width: 40.w,
          height: 40.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xffb2b2cc),
                width: 0.5.w,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
              borderRadius: BorderRadius.circular(80.r),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/apple_Icon.png"),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Container(
          width: 40.w,
          height: 40.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xffb2b2cc),
                width: 0.5.w,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/facebook_Icon.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
