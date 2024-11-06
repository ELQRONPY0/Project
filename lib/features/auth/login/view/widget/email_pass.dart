import 'package:ai_tumor_detect/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAndPass extends StatelessWidget {
  const EmailAndPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Email',
            validator: (value) {},
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            hintText: 'Password',
            validator: (value) {},
            prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
