import 'package:flutter/material.dart';
import 'dart:io';
import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';
import '../utils/weather_backgrounds.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  final String index;
  final double latitude;
  final double longitude;
  
  const WeatherScreen({
    super.key,
    required this.index,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final cachedData = await WeatherService.getCachedWeather();
    if (cachedData != null) {
      setState(() {
        _weatherData = cachedData;
      });
    }
    await _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weatherData = await WeatherService.fetchWeather(
        widget.latitude,
        widget.longitude,
      );
      
      await WeatherService.saveWeatherData(weatherData);
      
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } on SocketException {
      await _handleOfflineMode();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch weather data. Please try again.';
      });
    }
  }

  Future<void> _handleOfflineMode() async {
    final cachedData = await WeatherService.getCachedWeather();
    setState(() {
      _isLoading = false;
      _isOffline = true;
      if (cachedData != null) {
        _weatherData = cachedData.copyWith(isCached: true);
        _errorMessage = 'No internet connection. Showing cached data.';
      } else {
        _errorMessage = 'No internet connection and no cached data available';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _weatherData != null 
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    WeatherBackgroundUtils.getBackgroundFromWeatherCode(_weatherData!.weatherCode),
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(
                color: Color.fromARGB(255, 18, 96, 174),
              ),
        child: Column(
          children: [
            // Offline banner
            if (_isOffline && _weatherData != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'No internet connection. Displaying last viewed weather.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOffline = false;
                          _errorMessage = null;
                        });
                        _fetchWeather();
                      },
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            // Main content
            Expanded(
              child: SafeArea(
                top: !(_isOffline && _weatherData != null), 
                child: _isLoading 
                    ? const LoadingIndicator(message: 'Fetching weather data...')
                    : _weatherData != null 
                        ? _buildWeatherDisplay()
                        : _errorMessage != null
                            ? ErrorDisplay(
                                message: _errorMessage!,
                                onRetry: _fetchWeather,
                              )
                            : const Center(
                                child: Text(
                                  'No weather data available',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    final now = DateTime.now();
    final dayFormat = DateFormat('EEEE, MMM d');
    
    return Column(
      children: [
        // Temperature section
        Expanded(
          flex: 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.25),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_weatherData!.temperature.toInt()}°',
                        style: const TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 0.8,
                          letterSpacing: -4,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 20,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                       margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          dayFormat.format(now),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_weatherData!.isCached) 
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.amber.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.offline_bolt,
                          color: Colors.amber.shade900,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Cached',
                          style: TextStyle(
                            color: Colors.amber.shade900,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // Bottom weather details section
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 10, 50, 90),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Weather details
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.air,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Wind',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${_weatherData!.windSpeed.toStringAsFixed(1)} km/h',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.cloud,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Weather Code',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${_weatherData!.weatherCode}',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Last updated info
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Last updated at: ${_weatherData!.lastUpdated.substring(11, 16)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
              
              // Request URL 
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Text(
                  _weatherData!.requestUrl,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}