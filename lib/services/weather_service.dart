import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather_data.dart';

class WeatherService {
  static const String _cacheKey = 'weather_data';


  static Future<WeatherData?> getCachedWeather() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);
      if (cachedData != null) {
        final Map<String, dynamic> data = jsonDecode(cachedData);
        return WeatherData.fromJson(data);
      }
    } catch (e) {
      debugPrint('Error loading cached weather: $e');
    }
    return null;
  }

  static Future<void> saveWeatherData(WeatherData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(data.toJson()));
    } catch (e) {
      debugPrint('Error saving weather data: $e');
    }
  }

  static Future<WeatherData> fetchWeather(double latitude, double longitude) async {
    final requestUrl = 'https://api.open-meteo.com/v1/forecast?latitude=${latitude.toStringAsFixed(1)}&longitude=${longitude.toStringAsFixed(1)}&current_weather=true';
    final response = await http.get(Uri.parse(requestUrl));

    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final currentWeather = data['current_weather'];
      
      return WeatherData(
        temperature: currentWeather['temperature']?.toDouble() ?? 0.0,
        windSpeed: currentWeather['windspeed']?.toDouble() ?? 0.0,
        weatherCode: currentWeather['weathercode'] ?? 0,
        lastUpdated: DateTime.now().toString().substring(0, 19),
        requestUrl: requestUrl,
      );
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }
}