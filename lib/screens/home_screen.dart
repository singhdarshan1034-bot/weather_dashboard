import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_header.dart';
import '../widgets/weather_details.dart';
import '../widgets/forecast_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _showAppBar = _scrollController.offset > 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _showAppBar
            ? Theme.of(context).primaryColor.withOpacity(0.8)
            : Colors.transparent,
        title: _showAppBar
            ? Text(
                context.read<WeatherProvider>().selectedCity,
                style: Theme.of(context).textTheme.titleLarge,
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WeatherProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => provider.refreshWeather(),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          if (weatherProvider.isLoading && weatherProvider.currentWeather == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (weatherProvider.errorMessage != null &&
              weatherProvider.currentWeather == null) {
            return _buildErrorWidget(context, weatherProvider);
          }

          return RefreshIndicator(
            onRefresh: () async {
              weatherProvider.refreshWeather();
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SearchBarWidget(
                      onSearch: (city) {
                        weatherProvider.fetchWeatherByCity(city);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Weather Header
                  if (weatherProvider.currentWeather != null)
                    WeatherHeader(weather: weatherProvider.currentWeather!),
                  const SizedBox(height: 32),
                  // Current Weather Details
                  if (weatherProvider.currentWeather != null)
                    WeatherDetails(weather: weatherProvider.currentWeather!),
                  const SizedBox(height: 32),
                  // Forecast Section
                  if (weatherProvider.forecast.isNotEmpty)
                    _buildForecastSection(context, weatherProvider),
                  const SizedBox(height: 32),
                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                weatherProvider.fetchWeatherByCurrentLocation(),
                            icon: const Icon(Icons.location_on),
                            label: const Text('Current Location'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForecastSection(
      BuildContext context, WeatherProvider weatherProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5-Day Forecast',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: (weatherProvider.forecast.length / 8).ceil(),
            itemBuilder: (context, index) {
              final forecastIndex = index * 8;
              if (forecastIndex < weatherProvider.forecast.length) {
                return ForecastCard(
                  forecast: weatherProvider.forecast[forecastIndex],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(
      BuildContext context, WeatherProvider weatherProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              weatherProvider.errorMessage ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () =>
                  weatherProvider.fetchWeatherByCity(weatherProvider.selectedCity),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}