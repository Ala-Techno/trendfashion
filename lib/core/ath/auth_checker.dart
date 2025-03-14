import 'package:flutter/material.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/features/Onboarding/presintation/data/token_storage_Onboarding.dart';
import 'package:trendfashion/core/util/app_router.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        TokenStorage.getToken(),
        OnboardingStorage.isCompleted(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoadingScreen();
        }

        final token = snapshot.data?[0] as String?;
        final onboardingCompleted = snapshot.data?[1] as bool? ?? false;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNavigation(context, token, onboardingCompleted);
        });

        return _buildLoadingScreen();
      },
    );
  }

  void _handleNavigation(
      BuildContext context, String? token, bool onboardingCompleted) {
    if (token != null) {
      print('AuthChecker - Has Token: $token');
      print('AuthChecker - Onboarding Completed: $onboardingCompleted');
      Navigator.pushReplacementNamed(context, AppRouter.categories);
    } else {
      print(onboardingCompleted
          ? 'Navigating to SignUp'
          : 'Navigating to Onboarding');
      final route =
          onboardingCompleted ? AppRouter.signUp : AppRouter.onboarding;
      Navigator.pushReplacementNamed(context, route);
    }
  }

  Widget _buildLoadingScreen() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
