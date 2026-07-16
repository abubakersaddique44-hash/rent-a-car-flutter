import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static late SharedPreferences _prefs;

  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyOnboardingDone = 'onboarding_done';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Login Status
  static bool isLoggedIn() => _prefs.getBool(_keyIsLoggedIn) ?? false;
  static Future<void> setLoggedIn(bool value) => _prefs.setBool(_keyIsLoggedIn, value);

  // Dark Mode
  static bool isDarkMode() => _prefs.getBool(_keyDarkMode) ?? false;
  static Future<void> setDarkMode(bool value) => _prefs.setBool(_keyDarkMode, value);

  // Onboarding
  static bool isOnboardingDone() => _prefs.getBool(_keyOnboardingDone) ?? false;
  static Future<void> setOnboardingDone(bool value) => _prefs.setBool(_keyOnboardingDone, value);

  // Clear all
  static Future<void> clear() => _prefs.clear();
}
