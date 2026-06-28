import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather_model.dart';

class WeatherService {
  // Get your free API key from: https://openweathermap.org/api
  static const String _apiKey = 'YOUR_OPENWEATHER_API_KEY';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// Fetch weather data by city name
  Future<WeatherData> getWeatherByCity(String cityName) async {
    final url = '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherData.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw 'City not found. Please check the spelling and try again.';
      } else {
        throw 'Failed to fetch weather data. Status code: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Network error. Please check your internet connection.';
    } catch (e) {
      throw 'Error fetching weather: $e';
    }
  }

  /// Fetch weather data by coordinates (latitude, longitude)
  Future<WeatherData> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final url =
        '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherData.fromJson(jsonData);
      } else {
        throw 'Failed to fetch weather data. Status code: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Network error. Please check your internet connection.';
    } catch (e) {
      throw 'Error fetching weather: $e';
    }
  }

  /// Fetch 5-day weather forecast by city name
  Future<List<ForecastData>> getForecastByCity(String cityName) async {
    final url = '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> forecastList = jsonData['list'] ?? [];
        return forecastList.map((data) => ForecastData.fromJson(data)).toList();
      } else if (response.statusCode == 404) {
        throw 'City not found.';
      } else {
        throw 'Failed to fetch forecast data. Status code: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Network error. Please check your internet connection.';
    } catch (e) {
      throw 'Error fetching forecast: $e';
    }
  }

  /// Fetch 5-day weather forecast by coordinates
  Future<List<ForecastData>> getForecastByCoordinates(
      double latitude, double longitude) async {
    final url =
        '$_baseUrl/forecast?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> forecastList = jsonData['list'] ?? [];
        return forecastList.map((data) => ForecastData.fromJson(data)).toList();
      } else {
        throw 'Failed to fetch forecast data. Status code: ${response.statusCode}';
      }
    } on http.ClientException {
      throw 'Network error. Please check your internet connection.';
    } catch (e) {
      throw 'Error fetching forecast: $e';
    }
  }

  /// Get weather icon URL
  static String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@4x.png';
  }

  /// Get weather description based on condition
  static String getWeatherDescription(String condition) {
    final descriptions = {
      'Thunderstorm': '⛈️ Thunderstorm',
      'Drizzle': '🌧️ Drizzle',
      'Rain': '🌧️ Rainy',
      'Snow': '❄️ Snowy',
      'Mist': '🌫️ Misty',
      'Smoke': '💨 Smoky',
      'Haze': '🌫️ Hazy',
      'Dust': '🌪️ Dusty',
      'Fog': '🌫️ Foggy',
      'Sand': '🌪️ Sandy',
      'Ash': '🌋 Ashy',
      'Squall': '💨 Squall',
      'Tornado': '🌪️ Tornado',
      'Clear': '☀️ Clear',
      'Clouds': '☁️ Cloudy',
    };
    return descriptions[condition] ?? '🌤️ $condition';
  }
}