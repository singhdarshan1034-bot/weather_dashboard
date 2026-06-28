import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherData weather;

  const WeatherDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          // First Row
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.thermostat,
                  title: 'Temperature Range',
                  value: '${weather.tempMin.toStringAsFixed(0)}° - ${weather.tempMax.toStringAsFixed(0)}°',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.opacity,
                  title: 'Humidity',
                  value: '${weather.humidity}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Second Row
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.air,
                  title: 'Wind Speed',
                  value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.speed,
                  title: 'Wind Gust',
                  value: '${weather.windGust.toStringAsFixed(1)} m/s',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Third Row
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.cloud,
                  title: 'Cloud Cover',
                  value: '${weather.cloudiness}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.speed,
                  title: 'Pressure',
                  value: '${weather.pressure} hPa',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Fourth Row
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.visibility,
                  title: 'Visibility',
                  value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.wb_sunny,
                  title: 'UV Index',
                  value: weather.uvIndex.toStringAsFixed(1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sunrise and Sunset
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.sunrise,
                  title: 'Sunrise',
                  value: DateFormat('HH:mm').format(weather.sunrise),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.sunset_photo,
                  title: 'Sunset',
                  value: DateFormat('HH:mm').format(weather.sunset),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}