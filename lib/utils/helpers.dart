class Helpers {
  /// Convert temperature from Kelvin to Celsius
  static double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  /// Format date
  static String formatDate(String dateTime) {
    final date = DateTime.parse(dateTime);
    return '${date.day}/${date.month}/${date.year}';
  }
}
