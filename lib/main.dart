import 'package:flutter/material.dart';
import 'screens/input_screen.dart';
import 'constants/app_constants.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: AppTheme.theme,
      home: const InputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
