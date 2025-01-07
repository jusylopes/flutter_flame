import 'package:flutter/material.dart';
import 'package:flutter_flame/core/utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColorDark: AppColors.foregroundColor,
      textTheme: _buildTextTheme(),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: AppColors.foregroundColor,
        titleTextStyle: TextStyle(
          color: AppColors.textColor,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme:  IconThemeData(
        color: AppColors.iconColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      titleSmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: AppColors.textColorSubtitle),
    );
  }
}
