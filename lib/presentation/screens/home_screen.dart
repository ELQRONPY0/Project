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
  final Function(int)? onNavigate; // وظيفة للتنقل بين الصفحات

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
      const ExercisesPage(
        tumorType: "Breathing Exercise",
      ),
      const EffectsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        currentIndex: _currentIndex,
        // isNotHome: false,
        onNavigate: (index) {
          setState(() {
            _currentIndex = 0; // تغيير الفهرس للتنقل إلى الصفحة المطلوبة
          });
        },
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabs: const [
              GButton(icon: Iconsax.home, text: 'Home'),
              GButton(icon: Iconsax.health, text: "Diagnosis"),
              GButton(icon: Icons.fitness_center_outlined, text: "Exercises"),
              GButton(icon: Iconsax.heart_add, text: "Effects"),
            ],
          ),
        ),
      ),
    );
  }
}
