import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focudeErrorBorder,
    this.inputTextStyle,
    this.hintText,
    this.onSaved,
    this.onchange,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    required this.validator,
    this.controller,
  });

  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focudeErrorBorder;
  final TextStyle? inputTextStyle;
  final String? hintText;
  final void Function(String?)? onSaved;
  final void Function(String)? onchange;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Function(String?) validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 2;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      onChanged: onchange,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        constraints: BoxConstraints(
          maxHeight: height,
          maxWidth: width,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
        ),
        enabledBorder: enabledBorder ?? customBorder(),
        focusedBorder: focusedBorder ?? customBorder(Colors.lightBlue.shade100),
        errorBorder: errorBorder ?? customBorder(Colors.red),
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.red,
        ),
        focusedErrorBorder: focudeErrorBorder ?? customBorder(Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      validator: (value) {
        return validator(value);
      },
    );
  }

  OutlineInputBorder customBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: color ?? AppColor.primaryColor,
        width: 1.5,
      ),
    );
  }
}
