import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.blue,
  IconData? icon,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating, // يجعل الـ SnackBar يظهر بشكل عائم
      backgroundColor: backgroundColor, // لون الخلفية
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // الحواف المستديرة
      ),
      duration: const Duration(seconds: 3), // مدة العرض
    ),
  );
}
