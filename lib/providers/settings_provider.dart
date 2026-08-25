import 'package:flutter/material.dart';
import 'package:todo/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void init() {
    String theme = SharedPrefs.getTheme();
    if (theme == "light") {
      mode = ThemeMode.light;
    } else {
      mode = ThemeMode.dark;
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    mode = themeMode;
    if (themeMode == ThemeMode.light) {
      await SharedPrefs.setTheme("light");
    } else {
      await SharedPrefs.setTheme("dark");
    }
    notifyListeners();
  }
}
