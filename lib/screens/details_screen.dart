import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';

class DetailsScreen extends StatelessWidget {
  final String? city;

  const DetailsScreen({super.key, this.city});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(city != null
            ? 'Weather Details: $city'
            : 'Weather Details (Current Location)'),
        actions: [
          if (city == null)
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                weatherProvider.getWeatherByLocation();
              },
            ),
        ],
      ),
      body: FutureBuilder(
        future: city != null
            ? weatherProvider.getWeatherByCity(city!)
            : weatherProvider.getWeatherByLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final currentWeather = weatherProvider.currentWeather;
          final forecast = weatherProvider.forecast;

          if (currentWeather == null) {
            return Center(child: Text('Failed to fetch weather data.'));
          }

          return Column(
            children: [
              WeatherCard(weather: currentWeather),
              Expanded(
                child: ListView.builder(
                  itemCount: forecast.length,
                  itemBuilder: (context, index) {
                    return WeatherCard(weather: forecast[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
