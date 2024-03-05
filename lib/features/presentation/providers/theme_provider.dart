import 'package:flutter/material.dart';
import 'package:ingfo_movies/features/data/prefs/theme_preference.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final bool? isDarkMode = await ThemePreference.getTheme();
    if (isDarkMode != null) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    ThemePreference.setTheme(isDarkMode);
    notifyListeners();
  }
}
