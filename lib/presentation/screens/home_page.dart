import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/support_button.dart';
import 'package:ai_tumor_detect/presentation/widgets/stat_card.dart';
import 'package:ai_tumor_detect/presentation/widgets/tip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/user_provider.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate; // وظيفة للتنقل بين الصفحات

  const HomePage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
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
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user?.profileImage != null
                        ? NetworkImage(user!.profileImage!)
                        : const AssetImage('assets/images/logo.png')
                            as ImageProvider,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Welcome ${user?.name ?? "User"}!",
                    style: TextStyle(
                      color: AppColor.secondaryColor,
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
                  if (onNavigate != null) {
                    onNavigate!(1); // تغيير الفهرس إلى صفحة Diagnosis
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColor.primaryColor,
                        Color.fromARGB(255, 155, 238, 238),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Iconsax.health, size: 32, color: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Diagnosis",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Click to diagnose your symptoms.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
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
                  color: AppColor.secondaryColor,
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
                  color: AppColor.secondaryColor,
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

              // زر التمرين بعد التشخيص
              GestureDetector(
                onTap: () {
                  if (onNavigate != null) {
                    onNavigate!(2); // الانتقال إلى صفحة التمارين
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.fitness_center, size: 32, color: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended Exercises",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Click to see exercises for your condition.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              const CustomerSupportButton(),
            ],
          ),
        ),
      ),
    );
  }
}
