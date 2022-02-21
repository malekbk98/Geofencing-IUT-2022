import 'package:flutter/material.dart';

class AppTheme {
  static Color mainColor = const Color.fromRGBO(198, 120, 9, 1.0);
  static Color dark = const Color.fromRGBO(34, 36, 43, 1.0);
  static Color background = const Color.fromARGB(255, 49, 51, 58);

  static TextTheme textTheme = TextTheme(
    headline6: TextStyle(
      color: mainColor
    ),
    headline5: TextStyle(
      color: mainColor
    ),
    headline4: TextStyle(
      color: mainColor
    ),
    headline3: TextStyle(
      color: mainColor
    ),
    headline2: TextStyle(
      color: mainColor
    ),
    headline1: TextStyle(
      color: mainColor
    ),
  );
  
  static ProgressIndicatorThemeData? progressTheme = ProgressIndicatorThemeData(
    circularTrackColor: mainColor,
    color: background,
  );

  static ThemeData get theme {
    return ThemeData.dark().copyWith(
      primaryColor: mainColor,
      textTheme: textTheme,
      progressIndicatorTheme: progressTheme,
      backgroundColor: background,
      appBarTheme: AppBarTheme(
        color: dark
      ),
      scaffoldBackgroundColor: background,
    );
  }
}
