import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

enum ThemeSelected { dark, light }
var selectedTheme = ThemeSelected.dark;

class SetThemeState extends ChangeNotifier {
  ThemeSelected? selectedTheme;

  SetThemeState({
    this.selectedTheme,
  });
  void getTheme() => selectedTheme;

  void toggleTheme() {
    logger.w('Changing theme state');
    if (selectedTheme == ThemeSelected.dark) {
      selectedTheme = ThemeSelected.light;
    } else {
      selectedTheme = ThemeSelected.dark;
    }
    logger.w(selectedTheme);
    notifyListeners();
  }
}
