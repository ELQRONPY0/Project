import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/constant/string.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final Function(int)? onNavigate; // وظيفة للتنقل بين الصفحات

  const CustomAppBar({
    super.key,
    required this.currentIndex, // معامل مطلوب
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _isNotHome(currentIndex)
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.white,
                size: 24,
              ),
              onPressed: () {
                if (onNavigate != null) {
                  onNavigate!(0); // تغيير الفهرس إلى الصفحة الرئيسية (Home)
                } else {
                  Navigator.pop(context); // العودة للصفحة السابقة
                }
              },
            )
          : null,
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: AppColor.primaryColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.lightCyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getAppBarIcon(currentIndex),
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 18),
          Text(
            _getAppBarTitle(currentIndex),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Navigate to settings page
            Navigator.pushNamed(
                context, Routes.settingsPage); // تأكد من أن لديك صفحة إعدادات
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

String _getAppBarTitle(int index) {
  switch (index) {
    case 0:
      return "Home";
    case 1:
      return "Diagnosis";
    case 2:
      return "Exercises";
    case 3:
      return "Effects";
    default:
      return "App";
  }
}

IconData _getAppBarIcon(int index) {
  switch (index) {
    case 0:
      return Iconsax.home;
    case 1:
      return Iconsax.health;
    case 2:
      return Icons.fitness_center_outlined;
    case 3:
      return Iconsax.heart_add;
    default:
      return Iconsax.menu;
  }
}

bool _isNotHome(int index) {
  return index != 0; // زر الرجوع يظهر فقط إذا لم تكن في الصفحة الرئيسية
}
