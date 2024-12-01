import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:flutter/material.dart';

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Text(
          "Diagnosis Page!!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
