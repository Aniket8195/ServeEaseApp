import 'package:flutter/material.dart';

class AppPalette {
  static const Color primaryColor = Colors.teal;
  static const Color secondaryColor = Colors.tealAccent;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Colors.black87;
}

class ThemeClass {
  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        foregroundColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppPalette.primaryColor),
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppPalette.primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
      checkColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[200],
      disabledColor: Colors.grey,
      selectedColor: AppPalette.primaryColor,
      secondarySelectedColor: AppPalette.secondaryColor,
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: const TextStyle(color: AppPalette.textColor),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      brightness: Brightness.light,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(Colors.white),
      trackColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
      trackOutlineColor: WidgetStateProperty.all<Color>(AppPalette.primaryColor),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppPalette.primaryColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPalette.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppPalette.primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      labelStyle: const TextStyle(color: AppPalette.primaryColor),
      prefixIconColor: AppPalette.primaryColor,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppPalette.primaryColor,
      unselectedLabelColor: Colors.grey,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppPalette.primaryColor, width: 2),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppPalette.primaryColor,
      selectionColor: AppPalette.secondaryColor.withOpacity(0.3),
      selectionHandleColor: AppPalette.primaryColor,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppPalette.primaryColor),
      bodyMedium: TextStyle(fontSize: 16, color: AppPalette.textColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppPalette.primaryColor,
      secondary: AppPalette.secondaryColor,
      surface: AppPalette.backgroundColor,
    ),
  );
}