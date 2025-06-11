import 'package:json_annotation/json_annotation.dart';

part 'weather_wind.g.dart';

@JsonSerializable()
class Wind {
  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);

  final double? speed;
  final int? deg;
  final double? gust;

  Map<String, dynamic> toJson() => _$WindToJson(this);
}