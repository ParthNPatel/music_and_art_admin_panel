import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primaryColor: const Color(0xffffbfbfb),
  colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xff531255), tertiary: const Color(0xff4A4A4A)),
  focusColor: const Color(0xffebad3f), // instead of button color
  indicatorColor: const Color(0xff65CF7A),
  hintColor: const Color(0xffB0BAC9),
  disabledColor: const Color(0xffDFDFDF),
  shadowColor: const Color(0xff000000),
  errorColor: const Color(0xffD63649),

  drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff280035)),
  cardTheme: const CardTheme(
      color: Color(0xffffbfbfb), shadowColor: Color(0xff000000), elevation: 15),
  fontFamily: "Rubik",
  

  textTheme: const TextTheme(
    displaySmall: TextStyle(color: Colors.white, fontSize: 16),

    headlineLarge: TextStyle(
        color: Color(0xff531255), fontSize: 24, fontFamily: "IBMPlexSans"),
    headlineMedium: TextStyle(
        color: Color(0xff531255), fontSize: 22, fontFamily: "IBMPlexSans"),
    headlineSmall: TextStyle(
        color: Color(0xff531255), fontSize: 18, fontFamily: "IBMPlexSans"),

    titleLarge: TextStyle(color: Color(0xff531255), fontSize: 22),
    titleMedium: TextStyle(color: Color(0xff531255), fontSize: 18),
    titleSmall: TextStyle(color: Color(0xff531255), fontSize: 16),
    
    bodyLarge: TextStyle(color: Color(0xff4A4A4A), fontSize: 18),
    bodyMedium: TextStyle(color: Color(0xff4A4A4A), fontSize: 16),
    bodySmall: TextStyle(color: Color(0xff4A4A4A), fontSize: 14),
    
    labelLarge: TextStyle(color: Color(0xffB0BAC9), fontSize: 18),
    labelMedium: TextStyle(color: Color(0xffB0BAC9), fontSize: 16),
    labelSmall: TextStyle(color: Color(0xffB0BAC9), fontSize: 14),
  ),
);

/// [CustomColors]
///
/// use this class where [context] cannot be inherited
class CustomColors {
  /// white color
  static const Color white = Colors.white;

  /// yellow spectrum
  ///
  /// used for buttons
  static const Color focusColor = Color(0xffebad3f); // instead of button color

  /// green spectrum
  static const Color indicatorColor = Color(0xff65CF7A);

  /// light white sepctrum
  static const Color hintColor = Color(0xffB0BAC9);

  /// black color
  static const Color shadowColor = Color(0xff000000);

  /// black spectrum
  static const Color black = Color(0xff4A4A4A);

  /// blue spectrum
  static const Color blue = Color(0xff2C6EDF);

  /// grey spectrum
  ///
  /// which is used in __total case board titles__ bacground color
  static const Color totalCaseTableTitleColor = Color(0xffBFC5D2);

  /// grey spectrum
  ///
  /// [disable]
  static const Color disabledColor = Color(0xffDFDFDF);

  /// red specturm
  static const Color errorColor = Color(0xffD63649);
}

/// [CustomFonts]
///
/// use this class where context cannot be inherited
class CustomFonts {
  /// ibm plex sans
  static const String heading = "IBMPlexSans";

  /// rubik
  static const String body = "Rubik";
}