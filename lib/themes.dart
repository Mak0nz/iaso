import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withAlpha(200),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white.withAlpha(200),
      indicatorColor: Colors.blue.shade400,
      elevation: 3,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade400,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black26.withAlpha(220),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black26.withAlpha(220),
      indicatorColor: Colors.blue.shade400,
      elevation: 3,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade400,
    ),
  );
}