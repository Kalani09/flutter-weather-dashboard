import 'package:flutter/material.dart';
import '../utils/coordinate_calculator.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../constants/app_constants.dart';
import 'weather_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _indexController = TextEditingController(text: AppConstants.defaultIndex);
  late Map<String, double> _coordinates;

  @override
  void initState() {
    super.initState();
    _updateCoordinates();
  }

  void _updateCoordinates() {
    setState(() {
      _coordinates = CoordinateCalculator.calculateFromIndex(_indexController.text);
    });
  }

  void _navigateToWeatherScreen() {
    if (_indexController.text.length == 6) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WeatherScreen(
            index: _indexController.text,
            latitude: _coordinates['latitude']!,
            longitude: _coordinates['longitude']!,
          ),
        ),
      );
    } else {
      _showValidationError();
    }
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a valid 6-digit number'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  child: Column(
                    children: [
                      const Text(
                        'Hello !',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _indexController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Your Index',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        onChanged: (value) => _updateCoordinates(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.my_location, color: AppTheme.darkBlue),
                            const SizedBox(width: 10),
                            Text(
                              'Location: ${_coordinates['latitude']!.toStringAsFixed(2)}, ${_coordinates['longitude']!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppTheme.darkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Fetch Weather',
                        onPressed: _navigateToWeatherScreen,
                        backgroundColor: AppTheme.primaryBlue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _indexController.dispose();
    super.dispose();
  }
}