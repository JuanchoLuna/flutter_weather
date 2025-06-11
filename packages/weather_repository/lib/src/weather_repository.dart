import 'package:weather_repository/weather_repository.dart';

abstract class WeatherRepository {
  ///Throws [WeatherException] if fetching fails.
  /// Fetches the current weather for the given latitude and longitude.
  Future<WeatherResponse> getCurrentWeatherForLatAndLon({
    required String lat,
    required String lon,
  });

  ///Throws [WeatherException] if fetching fails.
  /// Fetches the current weather for the given city name.
  Future<WeatherResponse> getCurrentWeatherForCityName({
    required String cityName,
  });
}
