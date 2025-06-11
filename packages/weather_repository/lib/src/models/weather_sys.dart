import 'package:json_annotation/json_annotation.dart';

part 'weather_sys.g.dart';

@JsonSerializable()
class Sys {
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) =>
      _$SysFromJson(json);

  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Map<String, dynamic> toJson() => _$SysToJson(this);
}