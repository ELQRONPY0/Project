import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/support_button.dart';
import 'package:ai_tumor_detect/presentation/widgets/stat_card.dart';
import 'package:ai_tumor_detect/presentation/widgets/tip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo.gif'),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Welcome, User!",
                    style: TextStyle(
                      color: AppColor.scandryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/diagnosisPage');
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColor.lightCyan,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Iconsax.health,
                          size: 32, color: AppColor.primaryColor),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Diagnosis",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.scandryColor,
                              ),
                            ),
                            Text(
                              "Click to diagnose your symptoms.",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Your Statistics",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.scandryColor,
                ),
              ),
              SizedBox(height: 16.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCard(title: "Diagnoses Completed", value: "25"),
                  StatCard(title: "Pending Diagnoses", value: "5"),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "Medical Tips",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.scandryColor,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 120.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    TipCard(
                      tip:
                          "Tip: Early detection is key to effective treatment.",
                      color: Colors.blueAccent,
                    ),
                    TipCard(
                      tip: "Drink water and maintain a healthy diet.",
                      color: Colors.green,
                    ),
                    TipCard(
                      tip: "Stay active with regular exercise.",
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              const Supportbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
