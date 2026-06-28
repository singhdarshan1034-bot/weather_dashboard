# Weather Dashboard 🌤️

A beautiful, feature-rich Flutter weather application that fetches real-time weather data from the OpenWeatherMap API.

## ✨ Features

✅ **Real-time Weather Data**
- Current weather information with temperature, humidity, wind speed, and more
- 5-day weather forecast with hourly details
- Beautiful weather icons and animations

✅ **Location Services**
- Search weather by city name
- Fetch weather for current device location
- Automatic location-based weather updates

✅ **Detailed Weather Information**
- Temperature ranges (min/max)
- Humidity and pressure levels
- Wind speed and gust information
- Cloud coverage and visibility
- UV index tracking
- Sunrise and sunset times
- Rain probability

✅ **User Experience**
- Dark and light theme support
- Pull-to-refresh functionality
- Smooth animations and transitions
- Error handling with user-friendly messages
- Responsive design for all screen sizes
- Search autocomplete with recent cities

✅ **State Management**
- Provider pattern for efficient state management
- Caching of weather data
- Network connectivity detection

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.16.0 or higher)
- Android Studio or Xcode for emulator/simulator
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/weather_dashboard.git
   cd weather_dashboard
   ```

2. **Get your OpenWeatherMap API Key**
   - Go to https://openweathermap.org/api
   - Create a free account
   - Generate an API key (free tier includes current weather and forecast)

3. **Add your API key**
   - Open `lib/services/weather_service.dart`
   - Replace `YOUR_OPENWEATHER_API_KEY` with your actual API key
   ```dart
   static const String _apiKey = 'your_api_key_here';
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── weather_model.dart    # Weather data models
├── providers/
│   └── weather_provider.dart # State management
├── services/
│   └── weather_service.dart  # API integration
├── screens/
│   └── home_screen.dart      # Main screen
├── widgets/
│   ├── weather_header.dart   # Top weather display
│   ├── weather_details.dart  # Detailed information
│   ├── forecast_card.dart    # Forecast item
│   └── search_bar.dart       # City search
└── utils/
    └── theme.dart            # Theme configuration
```

## 🌐 API Integration

This app uses the **OpenWeatherMap API** for weather data:

### Endpoints Used

1. **Current Weather**
   - By city: `/weather?q={city}&units=metric`
   - By coordinates: `/weather?lat={lat}&lon={lon}&units=metric`

2. **5-Day Forecast**
   - By city: `/forecast?q={city}&units=metric`
   - By coordinates: `/forecast?lat={lat}&lon={lon}&units=metric`

### Free Tier Limits
- 60 requests per minute
- No cost for up to 1000 requests per day
- No credit card required

## 📦 Key Dependencies

- **provider**: State management
- **http**: HTTP client for API requests
- **google_fonts**: Beautiful typography
- **geolocator**: GPS location services
- **geocoding**: Convert coordinates to city names
- **shared_preferences**: Local data persistence
- **intl**: Date and time formatting

## 🎯 Features Explained

### 1. Current Weather Display
- Large temperature display with "feels like" temperature
- Weather condition icon from OpenWeatherMap
- Location information (city and country)
- Current date and time

### 2. Detailed Weather Information
- Temperature range (min/max)
- Humidity percentage
- Wind speed and gust
- Cloud coverage
- Atmospheric pressure
- Visibility distance
- UV Index
- Sunrise and sunset times

### 3. 5-Day Forecast
- Hourly forecast cards
- Temperature and "feels like" display
- Weather icons
- Rain probability
- Wind speed information

### 4. Location Services
- Use current device location
- Request and handle location permissions
- Display weather for found location

### 5. Search Functionality
- Search cities by name
- Autocomplete suggestions
- Recent cities list
- Error handling for invalid cities

## 🎨 Customization

### Change Temperature Units
In `weather_service.dart`, change `units=metric` to:
- `units=imperial` for Fahrenheit
- `units=standard` for Kelvin

### Change Theme Colors
Edit `lib/utils/theme.dart` to customize:
- Primary color
- Accent color
- Background colors
- Text styles

### Add More Weather Details
Extend `WeatherData` model in `weather_model.dart` to include additional fields from the API.

## 🧪 Testing

### Manual Testing Checklist
- [ ] Search for different cities
- [ ] Test with current location
- [ ] Verify all weather details display correctly
- [ ] Test pull-to-refresh
- [ ] Try both light and dark themes
- [ ] Test error handling (invalid city)
- [ ] Test network connectivity detection

## 🐛 Troubleshooting

### "City not found" error
- Ensure you're spelling the city name correctly
- Try using the full city name

### "Network error" message
- Check your internet connection
- Verify API key is correct
- Check if OpenWeatherMap API is accessible

### No location found
- Enable GPS on your device
- Grant location permissions to the app
- Wait for GPS to acquire position

### API calls not working
- Replace `cc876d9c61a6b8f6c8585487efc80164` with your actual key
- Verify your API key has the correct permissions
- Check the OpenWeatherMap API status page

## 📱 Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [OpenWeatherMap API](https://openweathermap.org/api) for weather data
- [Flutter](https://flutter.dev) framework
- [Google Fonts](https://fonts.google.com) for typography

## 📞 Support

For support, email support@weather.app or open an issue on GitHub.

---

**Built with ❤️ using Flutter**
