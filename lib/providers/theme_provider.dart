import 'package:flutter/material.dart';
import '../utils/pref_utils.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get themeMode => _mode;

  ThemeProvider() {
    _init();
  }

  void _init() {
    bool dark = PrefUtils.isDarkMode();
    _mode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setTheme(bool dark) async {
    _mode = dark ? ThemeMode.dark : ThemeMode.light;
    await PrefUtils.setDarkMode(dark);
    notifyListeners();
  }

  bool get isDark => _mode == ThemeMode.dark;
}
