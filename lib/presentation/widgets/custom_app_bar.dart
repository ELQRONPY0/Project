import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ai_tumor_detect/core/constant/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final bool isNotHome; // للتحكم في زر الرجوع

  const CustomAppBar({
    super.key,
    required this.currentIndex, // معامل مطلوب
    this.isNotHome = false, // قيمة افتراضية
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: _isNotHome(currentIndex), // إظهار زر الرجوع
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Action for settings
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
  if (index == 0) {
    return false;
  } else {
    return true;
  }
}
