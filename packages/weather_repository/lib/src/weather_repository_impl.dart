import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_repository/src/models/models.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<WeatherResponse> getCurrentWeatherForLatAndLon({
    required String lat,
    required String lon,
  }) async {
    final Uri url = Uri.parse(
      '${WeatherConst.weatherUrl}lat=$lat&l'
      'on=$lon&appid=${WeatherConst.apiKey}',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw WeatherException(
        'Failed to fetch weather data: ${response.statusCode} - ${response.reasonPhrase}',
      );
    }
    final data = WeatherResponse.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );

    return data;
  }

  @override
  Future<WeatherResponse> getCurrentWeatherForCityName({
    required String cityName,
  }) async {
    final Uri url = Uri.parse(
      '${WeatherConst.weatherUrl}q=$cityName&appid=${WeatherConst.apiKey}',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw WeatherException(
        'Failed to fetch weather data: ${response.statusCode} - ${response.reasonPhrase}',
      );
    }
    final data = WeatherResponse.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );

    return data;
  }
}
