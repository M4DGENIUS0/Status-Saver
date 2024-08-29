
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statussaver/Theme/Theme.dart';

class ThemeProvider with ChangeNotifier {
  SharedPreferences? sharedPreferences;
  ThemeProvider() {
    _loadThemeFromPreferences();
  }
  
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveThemeToPreferences(themeData == darkMode ? 'dark' : 'light');
    notifyListeners();
  }
  
  String _systemTheme = 'Default Theme';

  String get systemTheme => _systemTheme;

  var thememode = ThemeMode.light;
  ThemeMode get _thememode => thememode;
  setTheme(_thememode) {
    thememode = _thememode;
    if (_thememode == ThemeMode.light) {
      _systemTheme = 'Light Mode';
      themeData = lightMode;
    } else if (_thememode == ThemeMode.dark) {
      _systemTheme = 'Dark Mode';
       themeData = darkMode;
    } else {
      _systemTheme = 'System Mode';
      themeData = SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? darkMode
          : lightMode;
    }
    notifyListeners();
  }

   // Load the theme from SharedPreferences
  void _loadThemeFromPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences?.getString('theme');
    if (theme != null) {
      themeData = theme == 'dark' ? darkMode : lightMode;
    }
  }

  // Save the theme to SharedPreferences
  void _saveThemeToPreferences(String theme) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setString('theme', theme);
  }
}
