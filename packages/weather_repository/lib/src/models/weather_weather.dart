import 'package:json_annotation/json_annotation.dart';

part 'weather_weather.g.dart';

@JsonSerializable()
class Weather {
  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}