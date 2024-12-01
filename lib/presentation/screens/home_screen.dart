import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/presentation/screens/home_page.dart';
import 'package:ai_tumor_detect/presentation/screens/diagnosis_page.dart';
import 'package:ai_tumor_detect/presentation/screens/exercises_page.dart';
import 'package:ai_tumor_detect/presentation/screens/effects_page.dart';
import 'package:ai_tumor_detect/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DiagnosisPage(),
    const ExercisesPage(),
    const EffectsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        currentIndex: _currentIndex,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        color: AppColor.primaryColor,
        child: GNav(
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedIndex: _currentIndex,
          activeColor: Colors.white,
          color: Colors.white70,
          tabBackgroundColor: AppColor.lightCyan.withOpacity(0.2),
          tabs: const [
            GButton(icon: Iconsax.home, text: 'Home'),
            GButton(icon: Iconsax.health, text: "Diagnosis"),
            GButton(icon: Icons.fitness_center_outlined, text: "Exercises"),
            GButton(icon: Iconsax.heart_add, text: "Effects"),
          ],
        ),
      ),
    );
  }
}
