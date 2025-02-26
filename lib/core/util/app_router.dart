import 'package:trendfashion/core/ath/auth_checker.dart';
import 'package:trendfashion/features/Home/presintation/page/HomePage.dart';
import 'package:trendfashion/features/Introdaction/pages/firstPage.dart';
import 'package:trendfashion/features/Onboarding/presintation/page/OnboardingPage.dart';

import 'package:trendfashion/features/Product/presintation/page/productsPage.dart';
import 'package:trendfashion/features/Registration/presintation/page/LoginPage.dart';
import 'package:trendfashion/features/Registration/presintation/page/SingUp.dart';

class AppRouter {
  static const String initial = '/';
  static const String firstPage = '/first';
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String products = '/products';
  static const String categories = '/categories';
  static const String onboarding = '/onboarding';

  static final routes = {
    initial: (context) => const AuthChecker(),
    firstPage: (context) => const Firstpage(),
    signUp: (context) => const SingUpPage(),
    login: (context) => LoginPage(),
    products: (context) => const ProductPage(),
    categories: (context) =>  HomePage(),
    onboarding: (context) => const Onboarding(),
  };
}
