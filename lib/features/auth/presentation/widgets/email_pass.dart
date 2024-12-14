import 'package:ai_tumor_detect/core/helper/app_regex.dart';
import 'package:ai_tumor_detect/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAndPass extends StatefulWidget {
  final Function(String)
      onEmailChanged; // دالة لإرسال القيمة عند تغيير البريد الإلكتروني
  final Function(String)
      onPasswordChanged; // دالة لإرسال القيمة عند تغيير كلمة المرور
  final GlobalKey<FormState> formKey;

  const EmailAndPass({
    super.key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.formKey,
  });

  @override
  State<EmailAndPass> createState() => _EmailAndPassState();
}

class _EmailAndPassState extends State<EmailAndPass> {
  bool isPasswordObscureText = true;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    // إضافة المستمعين
    emailController.addListener(_emailChanged);
    passwordController.addListener(_passwordChanged);
  }

  // دالة للتعامل مع التغيير في البريد الإلكتروني
  void _emailChanged() {
    widget
        .onEmailChanged(emailController.text); // ارسال التغيير إلى الـ callback
  }

  // دالة للتعامل مع التغيير في كلمة المرور
  void _passwordChanged() {
    widget.onPasswordChanged(
        passwordController.text); // ارسال التغيير إلى الـ callback
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // البريد الإلكتروني
          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            validator: (value) =>
                (value?.isEmpty == true || !AppRegex.isEmailValid(value!))
                    ? 'Please enter a valid email'
                    : null,
            prefixIcon: Icon(Icons.email_outlined, size: 20.sp),
          ),
          SizedBox(height: 16.h),
// كلمة المرور
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            isObscureText: isPasswordObscureText,
            validator: (value) =>
                (value?.isEmpty == true || !AppRegex.isPasswordValid(value!))
                    ? 'Please enter a valid password'
                    : null,
            prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                size: 20.sp,
              ),
              onPressed: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
