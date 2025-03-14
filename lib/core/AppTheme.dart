import 'package:flutter/material.dart';

class AppTheme {
  ///colors
  static const Color primaryColor = Color(0xAA38bdf8);

  static MaterialColor primarySwatch = MaterialColor(Color(0xAA38bdf8).value, {
    50: const Color(0xAA38bdf8).withOpacity(.05),
    200: const Color(0xAA38bdf8).withOpacity(.2),
    300: const Color(0xAA38bdf8).withOpacity(.3),
    400: const Color(0xAA38bdf8).withOpacity(.4),
    500: const Color(0xAA38bdf8).withOpacity(.5),
    600: const Color(0xAA38bdf8).withOpacity(.6),
    700: const Color(0xAA38bdf8).withOpacity(.7),
    800: const Color(0xAA38bdf8).withOpacity(.8),
    900: const Color(0xAA38bdf8).withOpacity(.9)
  });

  static const Color secondaryColor = Color(0xAA4b6773);
  static MaterialColor secondarySwitch =
      MaterialColor(Color(0xAA4b6773).value, {
    50: const Color(0xAA4b6773).withOpacity(.05),
    100: const Color(0xAA4b6773).withOpacity(.1),
    200: const Color(0xAA4b6773).withOpacity(.2),
    300: const Color(0xAA4b6773).withOpacity(.3),
    400: const Color(0xAA4b6773).withOpacity(.4),
    500: const Color(0xAA4b6773).withOpacity(.5),
    600: const Color(0xAA4b6773).withOpacity(.6),
    700: const Color(0xAA4b6773).withOpacity(.7),
    800: const Color(0xAA4b6773).withOpacity(.8),
    900: const Color(0xAA4b6773).withOpacity(.9)
  });

  static Color scaffoldBackgroundColor = Color(0xffffff);
  static Color scaffoldBackgroundColor2 = Color(0xffF6F9);

  static String fontFamily1 = 'Raleway';
  static String fontFamily2 = 'Poppins';

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 18.0,
      fontFamily: fontFamily1,
      color: Colors.brown,
    ),
    displayMedium:
        TextStyle(fontSize: 16.0, fontFamily: fontFamily1, color: Colors.brown),
    displaySmall:
        TextStyle(fontSize: 14, fontFamily: fontFamily1, color: Colors.brown),
    headlineMedium: TextStyle(
        fontSize: 14, fontFamily: fontFamily1, color: AppTheme.primaryColor),
    headlineSmall:
        TextStyle(fontSize: 12.0, fontFamily: fontFamily1, color: Colors.brown),
    titleLarge: TextStyle(
        fontSize: 12.0, fontFamily: fontFamily1, color: AppTheme.primaryColor),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontFamily: fontFamily1,
      color: Colors.white,
    ),
    bodyMedium:
        TextStyle(fontSize: 20.0, fontFamily: fontFamily1, color: Colors.white),
  );
}
