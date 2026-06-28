import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatelessWidget {
  final ForecastData forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.2),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Day and Time
          Text(
            DateFormat('EEE').format(forecast.dateTime),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            DateFormat('HH:mm').format(forecast.dateTime),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 11,
                ),
          ),
          const SizedBox(height: 8),
          // Weather Icon
          Image.network(
            WeatherService.getWeatherIconUrl(forecast.icon),
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.cloud,
                size: 40,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
          const SizedBox(height: 8),
          // Temperature
          Text(
            '${forecast.temperature.toStringAsFixed(0)}°',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Feels Like
          Text(
            'Feels ${forecast.feelsLike.toStringAsFixed(0)}°',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          // Rain Probability
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.water_drop,
                size: 12,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 4),
              Text(
                '${(forecast.rainProbability * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: Colors.blueAccent,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Wind Speed
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.air,
                size: 12,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                '${forecast.windSpeed.toStringAsFixed(1)}m/s',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}