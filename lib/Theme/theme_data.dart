
import 'package:flutter/material.dart';
import 'package:serve_ease/Theme/app_pallete.dart';



class ThemeClass {
  //Color primaryColor = Colors.white;

  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
        WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        foregroundColor:
        WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPallete.primaryColor,
      selectedItemColor: AppPallete.secondaryColor,
      unselectedItemColor: Colors.grey,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all<Color>(Colors.white),
      checkColor: WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
    ),
    chipTheme: ChipThemeData(
      //backgroundColor: const Color(0xFF004A00),
      disabledColor: Colors.grey,
      selectedColor: AppPallete.secondaryColor,
      secondarySelectedColor: AppPallete.secondaryColor,
      labelPadding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: const TextStyle(color: Colors.black),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      brightness: Brightness.light,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(Colors.white),
      trackColor: WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
      trackOutlineColor:
      WidgetStateProperty.all<Color>(AppPallete.secondaryColor),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppPallete.secondaryColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      disabledActionBackgroundColor: Colors.grey,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppPallete.secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.secondaryColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      labelStyle: TextStyle(color: AppPallete.secondaryColor),

    ),
    drawerTheme: const DrawerThemeData(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppPallete.secondaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppPallete.secondaryColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppPallete.secondaryColor,
    ),

  );
}