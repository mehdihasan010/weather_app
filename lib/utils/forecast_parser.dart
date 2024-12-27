import '../models/weather_model.dart';

class ForecastParser {
  /// Parses the weather forecast data from the API response
  static List<WeatherModel> parseForecast(Map<String, dynamic> json) {
    final city = json['city']['name']; // Extract the city name
    return (json['list'] as List)
        .map((item) => WeatherModel.fromJson(item))
        .toList();
  }
}
