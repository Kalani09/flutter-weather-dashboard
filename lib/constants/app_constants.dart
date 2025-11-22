import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF64B5F6);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color darkBlue = Color(0xFF1976D2);
  
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class AppConstants {
  static const String appTitle = 'Weather App';
  static const String defaultIndex = '224028';
  static const double cardBorderRadius = 20.0;
  static const double buttonBorderRadius = 12.0;
}