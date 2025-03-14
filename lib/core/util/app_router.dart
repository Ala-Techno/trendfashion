import 'package:flutter/material.dart';
import 'package:trendfashion/core/ath/auth_checker.dart';
import 'package:trendfashion/features/Onboarding/presintation/page/OnboardingPage.dart';

import 'package:trendfashion/features/Product/presintation/page/productsPage.dart';
import 'package:trendfashion/features/Registration/presintation/page/LoginPage.dart';
import 'package:trendfashion/features/Registration/presintation/page/SingUp.dart';
import 'package:trendfashion/features/categories/presintation/page/categoriesPage.dart';

class AppRouter {
  static const String initialRoute = '/';
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String products = '/products';
  static const String categories = '/categories';
  static const String onboarding = '/onboarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const AuthChecker());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SingUpPage());
      case categories:
        return MaterialPageRoute(builder: (_) => CategoriesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
