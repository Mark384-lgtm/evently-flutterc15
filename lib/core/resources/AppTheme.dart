import 'package:flutter/material.dart';

import 'ColorManger.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManger.lightBackGroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManger.primaryColor,
      primary: ColorManger.primaryColor,
      onPrimary: Colors.black,
      tertiary: ColorManger.lightBackGroundColor,
      outline: ColorManger.darkGrey,
      onSecondary: ColorManger.darkGrey,
      secondary: Colors.black
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),

    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: ColorManger.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),

      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManger.DarkBackGroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManger.primaryColor,
      primary: ColorManger.primaryColor,
      onPrimary: Colors.white,
      tertiary: ColorManger.DarkBackGroundColor,
      outline: ColorManger.primaryColor,
      onSecondary: ColorManger.lightGrey,
      secondary: ColorManger.lightGrey,

    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),

    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: ColorManger.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
