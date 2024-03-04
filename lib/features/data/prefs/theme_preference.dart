import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String themeKey = 'THEME_KEY';

  static Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey);
  }

  static Future<void> setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode);
  }
}
