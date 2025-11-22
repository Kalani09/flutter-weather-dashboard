class CoordinateCalculator {
  static Map<String, double> calculateFromIndex(String index) {
    if (index.length != 6) {
      return {'latitude': 0.0, 'longitude': 0.0};
    }
    
    final firstTwo = int.tryParse(index.substring(0, 2)) ?? 0;
    final nextTwo = int.tryParse(index.substring(2, 4)) ?? 0;
    
    return {
      'latitude': 5 + (firstTwo / 10.0),
      'longitude': 79 + (nextTwo / 10.0),
    };
  }
}