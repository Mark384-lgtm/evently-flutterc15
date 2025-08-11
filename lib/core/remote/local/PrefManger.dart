import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefManger{
  static late SharedPreferences pref;

   static Future<void> inti() async {
    pref= await SharedPreferences.getInstance();
  }

  static setTheme(ThemeMode themeMode){
    if(themeMode == ThemeMode.dark){
      pref.setString(StringsManager.themeMode, StringsManager.darkTheme);
    }else{
      pref.setString(StringsManager.themeMode,StringsManager.lightTheme );
    }
  }
 static ThemeMode getTheme (){
    String mode= pref.getString(StringsManager.themeMode)?? StringsManager.lightTheme;
    return mode==StringsManager.darkTheme?ThemeMode.dark:ThemeMode.light;
  }
}