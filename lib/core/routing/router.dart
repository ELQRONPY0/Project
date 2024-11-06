import 'package:ai_tumor_detect/core/constant/string.dart';
import 'package:ai_tumor_detect/features/auth/login/view/screen/login_screen.dart';
import 'package:ai_tumor_detect/features/auth/signUp/view/screen/sign_up_screen.dart';
import 'package:ai_tumor_detect/features/onboarding/view/on_boarding.dart';
import 'package:ai_tumor_detect/features/onboarding/view/splash.dart';
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
