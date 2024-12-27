class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final DateTime date; // New property for date

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.date, // Include date in the constructor
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final city = json['name'];
    final temperature = json['main']?['temp'] ?? 0.0; // Extract temperature
    final description = (json['weather'] != null && json['weather'].isNotEmpty)
        ? json['weather'][0]['description'] ?? 'No Description'
        : 'No Description';
    final date = DateTime.fromMillisecondsSinceEpoch(
        json['dt'] * 1000); // Convert UNIX timestamp

    return WeatherModel(
      cityName: city,
      temperature: temperature,
      description: description,
      date: date,
    );
  }
}
