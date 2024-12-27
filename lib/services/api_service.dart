import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';
import '../utils/constants.dart';
import '../utils/forecast_parser.dart';

class ApiService {
  /// Fetch current weather by city name
  static Future<WeatherModel?> fetchCurrentWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.apiUrl}/weather?q=$city&units=metric&appid=${Constants.apiKey}'),
      );
      print("call api");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return WeatherModel.fromJson(data);
      } else {
        print('Failed to fetch weather: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }

  /// Fetch current weather by latitude and longitude
  static Future<WeatherModel?> fetchWeatherByCoordinates(
      String lat, String lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.apiUrl}/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        print('Failed to fetch weather by coordinates: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather by coordinates: $e');
      return null;
    }
  }

  /// Fetch 5-day weather forecast by latitude and longitude
  static Future<List<WeatherModel>> fetchForecastByCoordinates(
      String lat, String lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.apiUrl}/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ForecastParser.parseForecast(data);
      } else {
        print(
            'Failed to fetch forecast by coordinates: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching forecast by coordinates: $e');
      return [];
    }
  }
}
