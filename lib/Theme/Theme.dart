import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    onSecondary: Colors.black,
    onPrimary: Colors.grey.shade100,
    onSurface: Colors.grey.shade200,
      primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    ),
);
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
    onSecondary: Colors.white,

      onPrimary: Colors.grey.shade800,
      onSurface: Colors.grey.shade800,
        primary: Colors.grey.shade300,
      surface: Colors.grey.shade900,
    secondary: Colors.grey.shade200,
    ));
