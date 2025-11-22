# Weather App 🌤️

A beautiful, cross-platform Flutter weather application that fetches real-time weather data based on custom index coordinates. Features elegant UI with dynamic backgrounds, local caching, and comprehensive weather information display.

> **Note**: This project was created as part of a university assignment for wireless communication and mobile development coursework.

## ✨ Features

- **Real-time Weather Data**: Fetches current weather conditions using Open-Meteo API
- **Custom Index System**: Converts 6-digit index codes to geographic coordinates
- **Dynamic Backgrounds**: Weather-themed gradient backgrounds that adapt to current conditions
- **Local Caching**: Stores weather data locally for offline viewing with SharedPreferences
- **Responsive Design**: Beautiful Material 3 design that works across all platforms
- **Weather Icons**: Custom weather condition indicators with intuitive icons
- **Error Handling**: Comprehensive error states with user-friendly messages
- **Multi-platform**: Supports Android, iOS, Web, Windows, macOS, and Linux

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK
- An IDE (VS Code, Android Studio, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd weather_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   └── app_constants.dart    # Theme and app constants
├── models/
│   └── weather_data.dart     # Weather data model
├── screens/
│   ├── input_screen.dart     # Index input interface
│   └── weather_screen.dart   # Weather display interface
├── services/
│   └── weather_service.dart  # API and caching service
├── utils/
│   ├── coordinate_calculator.dart  # Index to coordinate conversion
│   └── weather_backgrounds.dart   # Dynamic background logic
└── widgets/
    ├── cached_indicator.dart       # Cache status indicator
    ├── custom_button.dart         # Reusable button component
    ├── custom_card.dart          # Weather info cards
    ├── error_display.dart        # Error state display
    ├── gradient_background.dart  # Dynamic gradient backgrounds
    ├── loading_indicator.dart    # Loading state indicator
    ├── location_display.dart     # Coordinate display
    ├── weather_detail_item.dart  # Weather detail components
    └── widgets.dart             # Widget exports
```

## 🎨 Key Components

### Coordinate System
The app uses a unique 6-digit index system that converts to geographic coordinates:
- **Index Format**: XYZZWW (6 digits)
- **Latitude**: 5 + (XY / 10.0)
- **Longitude**: 79 + (ZZ / 10.0)
- **Default Index**: 224028

### Weather Service
- Fetches data from Open-Meteo API
- Implements local caching with SharedPreferences
- Provides offline functionality
- Handles network errors gracefully

### Dynamic UI
- Weather-themed backgrounds
- Responsive card-based layout
- Material 3 design system
- Cross-platform compatibility

## 📦 Dependencies

- **http**: ^1.1.0 - API requests
- **shared_preferences**: ^2.2.2 - Local data persistence
- **intl**: ^0.19.0 - Date formatting
- **cupertino_icons**: ^1.0.8 - iOS-style icons

## 🌍 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎯 Usage

1. **Launch the app** - Opens to index input screen
2. **Enter 6-digit index** - Input your location index (default: 224028)
3. **Fetch Weather** - Tap "Get Weather" to retrieve current conditions
4. **View Details** - See temperature, wind speed, and weather conditions
5. **Cached Data** - Previously fetched data is available offline

## 🏗️ Architecture

The app follows a clean architecture pattern:

- **Models**: Data structures for weather information
- **Services**: Business logic for API calls and caching
- **Screens**: Main UI pages and navigation
- **Widgets**: Reusable UI components
- **Utils**: Helper functions and calculations
- **Constants**: App-wide configuration and theming

## 🎨 Weather Conditions

The app supports various weather conditions with corresponding backgrounds:
- ☀️ Sunny/Clear
- ⛅ Cloudy
- 🌧️ Rainy
- ⛈️ Thunderstorm
- 🌫️ Foggy
- ❄️ Snowy

## 🔧 Configuration

### API Endpoint
- **Service**: Open-Meteo API
- **Endpoint**: `https://api.open-meteo.com/v1/forecast`
- **Parameters**: latitude, longitude, current_weather

### Theme Customization
Modify `lib/constants/app_constants.dart` to customize:
- Primary colors
- Border radius values
- App title and defaults

## 🚀 Build & Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Built with ❤️ using Flutter**
