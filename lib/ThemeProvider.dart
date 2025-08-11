import 'package:evently_c15_flutter/core/remote/local/PrefManger.dart';
import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
   late ThemeMode themeMode;

  void init() {
    themeMode = PrefManger.getTheme();
  }

  void changeTheme(ThemeMode new_themeMode) {
    print("\n passed thememode = $new_themeMode");
    if (themeMode != new_themeMode) {
      themeMode = new_themeMode;
      PrefManger.setTheme(themeMode);
      print("\nthemeMode = $themeMode");
      notifyListeners();
    }
  }
}
