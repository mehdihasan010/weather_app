import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    Future<void> refreshItems() async {
      weatherProvider.getWeatherByLocation();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sky Sync'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              weatherProvider.getWeatherByLocation();
            },
          ),
        ],
      ),
      body: weatherProvider.currentWeather == null
          ? Center(
              child: Text('Press the location icon to get weather updates.'))
          : RefreshIndicator(
              onRefresh: refreshItems,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/night.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    WeatherCard(weather: weatherProvider.currentWeather!),
                    Expanded(
                      child: ListView.builder(
                        itemCount: weatherProvider.forecast.length,
                        itemBuilder: (context, index) {
                          return WeatherCard(
                              weather: weatherProvider.forecast[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
