import 'package:ai_tumor_detect/core/constant/string.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 450000));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Center(
        child: SizedBox(
          width: 155,
          height: 155,
          child: Image.asset(
            "assets/images/logo.gif",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
