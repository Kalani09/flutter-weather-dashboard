class WeatherBackgroundUtils {
  static bool isBetween(int code, int a, int b) => code >= a && code <= b;

  // Get weather background type
  static String getBackground(int code) {
    if (code == 0 || code == 1) return 'sunny';
    if (code == 2 || code == 3) return 'cloudy';
    if (code == 45 || code == 48) return 'fog';

    if (isBetween(code, 51, 57)) return 'drizzle';        // 51–57
    if (isBetween(code, 61, 67)) return 'rain';          
    if (isBetween(code, 71, 77)) return 'snow';           
    if (isBetween(code, 80, 86)) return 'showers';        
    if (isBetween(code, 95, 99)) return 'thunderstorm';   

    return 'unknown';
  }

  // Get weather background image path based on background type
  static String getWeatherBackgroundPath(String backgroundType) {
    switch (backgroundType) {
      case 'sunny':
        return 'assets/images/sunny.jpg';
      case 'cloudy':
        return 'assets/images/cloudy.jpg';
      case 'fog':
        return 'assets/images/fog.jpg';
      case 'drizzle':
      case 'rain':
      case 'showers':
        return 'assets/images/rain.jpg'; 
      case 'snow':
        return 'assets/images/snow.jpg';
      case 'thunderstorm':
        return 'assets/images/thunderstorm.jpg';
      default:
        return 'assets/images/sunny.jpg'; // Default fallback
    }
  }

  // Convenience method to get background image path directly from weather code
  static String getBackgroundFromWeatherCode(int weatherCode) {
    return getWeatherBackgroundPath(getBackground(weatherCode));
  }
}