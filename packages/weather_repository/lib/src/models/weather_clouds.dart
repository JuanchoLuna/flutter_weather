import 'package:json_annotation/json_annotation.dart';

part 'weather_clouds.g.dart';

@JsonSerializable()
class Clouds {
  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  final int? all;

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}
