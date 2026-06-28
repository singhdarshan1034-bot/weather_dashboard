import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';

class WeatherHeader extends StatelessWidget {
  final WeatherData weather;

  const WeatherHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // City Name and Date
          Text(
            '${weather.cityName}, ${weather.country}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('EEEE, MMMM d, yyyy').format(weather.dateTime),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 24),
          // Weather Icon
          Image.network(
            WeatherService.getWeatherIconUrl(weather.icon),
            width: 120,
            height: 120,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                _getWeatherIcon(weather.main),
                size: 100,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
          const SizedBox(height: 16),
          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${weather.temperature.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 64,
                    ),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.main,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Feels like ${weather.feelsLike.toStringAsFixed(0)}°',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            weather.description.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'thunderstorm':
        return Icons.flash_on;
      case 'drizzle':
      case 'rain':
        return Icons.cloud_queue;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return Icons.cloud_queue;
      case 'clear':
        return Icons.sunny;
      case 'clouds':
        return Icons.cloud;
      default:
        return Icons.wb_cloudy;
    }
  }
}