import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udenwa_prosper/src/constants/string_constants.dart';
import '../app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColor.primaryColor,
        onSecondary: Colors.white,
        error: AppColor.errorColor,
        onError: Colors.white,
        background: Colors.white,
        onBackground: AppColor.primaryColor,
        surface: Colors.white,
        onSurface: AppColor.primaryColor,
      ),
      fontFamily: StringConstants.fontFamily,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      iconTheme: IconThemeData(color: AppColor.textColor),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
        labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
        labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: AppColor.textColor),
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColor.textColor),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(color: AppColor.disabledColor, width: 0.6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.disabledColor, width: 0.5)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.disabledColor, width: 0.5)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.textColor, width: 1)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.errorColor, width: 1)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.errorColor, width: 0.5),
        ),
        isDense: false,
        contentPadding: const EdgeInsets.all(15),
        errorStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.redAccent),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primaryColor,
          disabledBackgroundColor: AppColor.disabledColor,
          disabledForegroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: AppColor.textColor,
          side: BorderSide(color: AppColor.textColor),
          disabledForegroundColor: AppColor.disabledColor,
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.maxFinite, 50),
          foregroundColor: AppColor.primaryColor,
          disabledForegroundColor: AppColor.disabledColor,
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColor.primaryColor,
      fontFamily: StringConstants.fontFamily,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400, color: Colors.white),
        displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400, color: Colors.white),
        displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400, color: Colors.white),
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.white),
        headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400, color: Colors.white),
        headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: Colors.white),
        titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, color: Colors.white),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
        labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white),
        labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.disabledColor, width: 0.5)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.disabledColor, width: 0.5)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.textColor, width: 1)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.errorColor, width: 1)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: AppColor.errorColor, width: 0.5)
        ),
        isDense: false,
        contentPadding: const EdgeInsets.all(15),
        errorStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.redAccent),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(color: AppColor.disabledColor, width: 0.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primaryColor,
          disabledBackgroundColor: AppColor.disabledColor,
          disabledForegroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: AppColor.primaryColor),
          foregroundColor: AppColor.primaryColor,
          disabledForegroundColor: AppColor.disabledColor,
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
