import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherData? _currentWeather;
  List<ForecastData> _forecast = [];
  List<WeatherData> _savedCities = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCity = 'London';
  bool _useCurrentLocation = false;

  // Getters
  WeatherData? get currentWeather => _currentWeather;
  List<ForecastData> get forecast => _forecast;
  List<WeatherData> get savedCities => _savedCities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCity => _selectedCity;
  bool get useCurrentLocation => _useCurrentLocation;

  WeatherProvider() {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadSavedCities();
    await fetchWeatherByCity('London');
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedCity = cityName;
    _useCurrentLocation = false;
    notifyListeners();

    try {
      final weather = await _weatherService.getWeatherByCity(cityName);
      final forecast = await _weatherService.getForecastByCity(cityName);

      _currentWeather = weather;
      _forecast = forecast;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _currentWeather = null;
      _forecast = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCoordinates(double latitude, double longitude) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weather =
          await _weatherService.getWeatherByCoordinates(latitude, longitude);
      final forecast =
          await _weatherService.getForecastByCoordinates(latitude, longitude);

      _currentWeather = weather;
      _forecast = forecast;
      _selectedCity = weather.cityName;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _currentWeather = null;
      _forecast = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCurrentLocation() async {
    _isLoading = true;
    _errorMessage = null;
    _useCurrentLocation = true;
    notifyListeners();

    try {
      final position = await _getCurrentLocation();
      await fetchWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      _errorMessage = e.toString();
      _useCurrentLocation = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> addCityToSaved(String cityName) async {
    try {
      final weather = await _weatherService.getWeatherByCity(cityName);
      if (!_savedCities.any((city) => city.cityName == cityName)) {
        _savedCities.add(weather);
        await _saveCitiesToPreferences();
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeCityFromSaved(String cityName) async {
    _savedCities.removeWhere((city) => city.cityName == cityName);
    await _saveCitiesToPreferences();
    notifyListeners();
  }

  Future<void> _loadSavedCities() async {
    // Implementation for loading from SharedPreferences
  }

  Future<void> _saveCitiesToPreferences() async {
    // Implementation for saving to SharedPreferences
  }

  void refreshWeather() {
    if (_useCurrentLocation) {
      fetchWeatherByCurrentLocation();
    } else {
      fetchWeatherByCity(_selectedCity);
    }
  }
}