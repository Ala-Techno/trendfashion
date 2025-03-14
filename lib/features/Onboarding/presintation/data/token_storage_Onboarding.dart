// onboarding_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingStorage {
  static const _key = 'onboarding_completed';

  // Check if onboarding was completed
  static Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false; // Default: false (not completed)
  }

  // Mark onboarding as completed
  static Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
