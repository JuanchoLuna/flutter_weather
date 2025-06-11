class WeatherException implements Exception {
  WeatherException(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => errorMessage;
}
