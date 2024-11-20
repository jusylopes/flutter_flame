import 'package:flutter/material.dart';
import 'package:flutter_flame/utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColorDark: AppColors.foregroundColor,
    );
  }
}
