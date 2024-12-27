import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import '../services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _currentWeather;
  List<WeatherModel> _forecast = [];

  WeatherModel? get currentWeather => _currentWeather;
  List<WeatherModel> get forecast => _forecast;

  /// Fetch weather based on city
  Future<void> getWeatherByCity(String city) async {
    try {
      _currentWeather = await ApiService.fetchCurrentWeather(city);
      notifyListeners();
    } catch (e) {
      print("Error fetching weather by city: $e");
    }
  }

  /// Fetch weather using the current location
  Future<void> getWeatherByLocation() async {
    try {
      Position position = await _determinePosition();
      String lat = position.latitude.toString();
      String lon = position.longitude.toString();

      _currentWeather = await ApiService.fetchWeatherByCoordinates(lat, lon);
      _forecast = await ApiService.fetchForecastByCoordinates(lat, lon);

      notifyListeners();
    } catch (e) {
      print("Error fetching weather by location: $e");
    }
  }

  /// Helper method to get user's location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied. We cannot request permissions.");
    }

    return await Geolocator.getCurrentPosition();
  }
}
