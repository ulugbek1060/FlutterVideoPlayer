import 'package:flutter/material.dart';

class AppTheme {
  static final elevatedButton = ElevatedButton.styleFrom(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    // side: BorderSide(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // <-- Radius
    ),
    elevation: 0.5,
  );

  final iconButton = IconButton.styleFrom(
    highlightColor: Colors.white,
    focusColor: Colors.white,
  );

  final defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.white,
  );

  final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
  );

  static ThemeData lightTheme() {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF408EFF),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButton),
    );
  }

  static ThemeData darkTheme() {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF408EFF),
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButton),
    );
  }
}
