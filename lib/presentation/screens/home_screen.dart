import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/presentation/screens/home_page.dart';
import 'package:ai_tumor_detect/presentation/screens/diagnosis_page.dart';
import 'package:ai_tumor_detect/presentation/screens/exercises_page.dart';
import 'package:ai_tumor_detect/presentation/screens/effects_page.dart';
import 'package:ai_tumor_detect/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة flutter_screenutil

class HomeScreen extends StatefulWidget {
  final Function(int)? onNavigate;

  const HomeScreen({super.key, this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late List<Widget> _pages;

  get onNavigate => widget.onNavigate;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        onNavigate: _onNavigate,
      ),
      DiagnosisPage(
        onNavigate: _onNavigate,
      ),
      ExercisesPage(),
      EffectsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        currentIndex: _currentIndex,
        onNavigate: (index) {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 80.h, // استخدام h من flutter_screenutil
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(20.r), // استخدام r للتأكد من أن القيمة مرنة
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h), // استخدام w و h من flutter_screenutil
          child: GNav(
            gap: 8.w,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedIndex: _currentIndex,
            activeColor: Colors.white,
            color: Colors.white70,
            tabBackgroundColor: AppColor.lightCyan.withOpacity(0.2),
            padding: EdgeInsets.symmetric(
                horizontal: 18.w, vertical: 10.h), // استخدام w و h هنا أيضًا
            tabs: const [
              GButton(
                icon: Iconsax.home,
                text: 'Home',
              ),
              GButton(
                icon: Iconsax.health,
                text: "Diagnosis",
              ),
              GButton(
                icon: Icons.fitness_center_outlined,
                text: "Exercises",
              ),
              GButton(
                icon: Iconsax.heart_add,
                text: "Effects",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
