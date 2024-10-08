import 'package:flutter/material.dart';
import 'package:flutter_flame/screens/home_screen.dart';
import 'package:flutter_flame/utils/app_theme.dart';

class FlameApp extends StatelessWidget {
  const FlameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
