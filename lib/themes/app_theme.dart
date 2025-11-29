import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color.fromARGB(255, 118, 110, 110),
    cardColor: Colors.grey.shade100,
    hintColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: const Color.fromARGB(255, 100, 98, 98)),
    ),
    colorScheme: ColorScheme.light(
      secondary: Colors.grey.shade300,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121212),
    primaryColor: Colors.amber,
    cardColor: Color(0xFF1E1E1E),
    hintColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      secondary: Colors.grey.shade800,
    ),
  );
}
