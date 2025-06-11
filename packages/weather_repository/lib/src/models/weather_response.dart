import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  WeatherResponse({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeatherData? main;
  final int? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
