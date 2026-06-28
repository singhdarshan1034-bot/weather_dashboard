class WeatherData {
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final double windGust;
  final int cloudiness;
  final String description;
  final String main;
  final String icon;
  final DateTime sunrise;
  final DateTime sunset;
  final double visibility;
  final double uvIndex;
  final DateTime dateTime;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windGust,
    required this.cloudiness,
    required this.description,
    required this.main,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.visibility,
    required this.uvIndex,
    required this.dateTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final wind = json['wind'] ?? {};
    final clouds = json['clouds'] ?? {};
    final sys = json['sys'] ?? {};
    final weather = json['weather'] != null && json['weather'].isNotEmpty
        ? json['weather'][0]
        : {};

    return WeatherData(
      cityName: json['name'] ?? 'Unknown',
      country: sys['country'] ?? '',
      latitude: json['coord']?['lat']?.toDouble() ?? 0.0,
      longitude: json['coord']?['lon']?.toDouble() ?? 0.0,
      temperature: (main['temp'] ?? 0).toDouble(),
      feelsLike: (main['feels_like'] ?? 0).toDouble(),
      tempMin: (main['temp_min'] ?? 0).toDouble(),
      tempMax: (main['temp_max'] ?? 0).toDouble(),
      humidity: main['humidity'] ?? 0,
      pressure: main['pressure'] ?? 0,
      windSpeed: (wind['speed'] ?? 0).toDouble(),
      windGust: (wind['gust'] ?? 0).toDouble(),
      cloudiness: clouds['all'] ?? 0,
      description: weather['description'] ?? 'No description',
      main: weather['main'] ?? 'Unknown',
      icon: weather['icon'] ?? '01d',
      sunrise: DateTime.fromMillisecondsSinceEpoch((sys['sunrise'] ?? 0) * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch((sys['sunset'] ?? 0) * 1000),
      visibility: (json['visibility'] ?? 10000).toDouble(),
      uvIndex: json['uvi']?.toDouble() ?? 0.0,
      dateTime: DateTime.now(),
    );
  }
}

class ForecastData {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final String description;
  final String main;
  final String icon;
  final double windSpeed;
  final double rainProbability;
  final double rainfall;

  ForecastData({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.description,
    required this.main,
    required this.icon,
    required this.windSpeed,
    required this.rainProbability,
    required this.rainfall,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final wind = json['wind'] ?? {};
    final weather = json['weather'] != null && json['weather'].isNotEmpty
        ? json['weather'][0]
        : {};

    return ForecastData(
      dateTime: DateTime.parse(json['dt_txt'] ?? DateTime.now().toIso8601String()),
      temperature: (main['temp'] ?? 0).toDouble(),
      feelsLike: (main['feels_like'] ?? 0).toDouble(),
      tempMin: (main['temp_min'] ?? 0).toDouble(),
      tempMax: (main['temp_max'] ?? 0).toDouble(),
      humidity: main['humidity'] ?? 0,
      description: weather['description'] ?? 'No description',
      main: weather['main'] ?? 'Unknown',
      icon: weather['icon'] ?? '01d',
      windSpeed: (wind['speed'] ?? 0).toDouble(),
      rainProbability: (json['pop'] ?? 0).toDouble(),
      rainfall: (json['rain']?['3h'] ?? 0).toDouble(),
    );
  }
}