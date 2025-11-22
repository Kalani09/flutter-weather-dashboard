class WeatherData {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final String lastUpdated;
  final String requestUrl;
  final bool isCached;

  const WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.lastUpdated,
    required this.requestUrl,
    this.isCached = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windSpeed': windSpeed,
      'weatherCode': weatherCode,
      'lastUpdated': lastUpdated,
      'requestUrl': requestUrl,
    };
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['temperature']?.toDouble() ?? 0.0,
      windSpeed: json['windSpeed']?.toDouble() ?? 0.0,
      weatherCode: json['weatherCode'] ?? 0,
      lastUpdated: json['lastUpdated'] ?? '',
      requestUrl: json['requestUrl'] ?? '',
      isCached: true,
    );
  }

  WeatherData copyWith({
    double? temperature,
    double? windSpeed,
    int? weatherCode,
    String? lastUpdated,
    String? requestUrl,
    bool? isCached,
  }) {
    return WeatherData(
      temperature: temperature ?? this.temperature,
      windSpeed: windSpeed ?? this.windSpeed,
      weatherCode: weatherCode ?? this.weatherCode,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      requestUrl: requestUrl ?? this.requestUrl,
      isCached: isCached ?? this.isCached,
    );
  }
}