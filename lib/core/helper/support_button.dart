import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerSupportButton extends StatelessWidget {
  const CustomerSupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 94, 230, 230),
        iconColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
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
      icon: const Icon(Icons.help),
      label: Text("Need Help?",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ));
  }
}
