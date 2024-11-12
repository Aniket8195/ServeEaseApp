import 'package:flutter/material.dart';

class AppPallete {
  // Main colors
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF004A00);

  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;

  // Text colors
  static const Color primaryTextColor = Color(0xFF1D1B20);
  static const Color secondaryTextColor = Color(0xFF49454F);

  // Accent colors
  static const Color accentColor = Color(0xFFEADDFF);
  static const Color errorColor = Color(0xFFB3261E);

  // Additional colors
  static const Color disabledColor = Color(0xFFCAC4D0);
  static const Color borderColor = Color(0xFFE0E0E0);

  // Button colors
  static Color get elevatedButtonColor => primaryColor;
  static Color get elevatedButtonTextColor => Colors.white;
  static Color get outlinedButtonColor => primaryColor;
  static Color get outlinedButtonTextColor => primaryColor;

  // Input decoration colors
  static Color get inputFillColor => surfaceColor;
  static Color get inputBorderColor => borderColor;
  static Color get inputFocusedBorderColor => primaryColor;
  static Color get inputLabelColor => secondaryTextColor;
  static Color get inputIconColor => primaryColor;

  static Color get successColor => Colors.green.shade200;

}