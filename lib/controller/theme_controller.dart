import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeData theme = ThemeData.dark();
  Icon iconTheme = const Icon(Icons.light_mode);

  void selectTheme() {
    if (theme.brightness == Brightness.light) {
      theme = ThemeData.dark();
      iconTheme = const Icon(Icons.light_mode);
    } else {
      theme = ThemeData.light();
      iconTheme = const Icon(Icons.mode_night);
    }
    notifyListeners();
  }
}