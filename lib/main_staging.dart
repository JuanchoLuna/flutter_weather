import 'package:flutter_weather/app/app.dart';
import 'package:flutter_weather/bootstrap.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  bootstrap(
    () => App(
      weatherRepository: WeatherRepositoryImpl(),
    ),
  );
}
