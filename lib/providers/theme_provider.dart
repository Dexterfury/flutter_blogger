import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode;

  // constructor
  ThemeProvider({bool isDarkMode = false}) : _isDarkMode = isDarkMode;

  // getter
  bool get isDarkMode => _isDarkMode;

  // toggle theme
  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();

    // save to shared preferences
    saveTheme();
  }

  // save theme to shared preferences
  void saveTheme() async {
    // save to shared preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isDarkMode', _isDarkMode);
  }

  // get theme from shared preferences
  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDarkMode = sharedPreferences.getBool('isDarkMode');
    if (isDarkMode != null) {
      _isDarkMode = isDarkMode;
      return _isDarkMode;
    }
    return false;
  }
}
