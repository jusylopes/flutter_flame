import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    );
  }
}
