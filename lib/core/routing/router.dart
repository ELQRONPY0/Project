import 'package:ai_tumor_detect/core/constant/string.dart';
import 'package:ai_tumor_detect/features/auth/presentation/screens/login_screen.dart';
import 'package:ai_tumor_detect/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ai_tumor_detect/presentation/screens/diagnosis_page.dart';
import 'package:ai_tumor_detect/presentation/screens/home_screen.dart';
import 'package:ai_tumor_detect/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:ai_tumor_detect/presentation/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const Splash());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (context) => const Onboarding());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.diagnosisPage:
        return MaterialPageRoute(builder: (context) => const DiagnosisPage());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
