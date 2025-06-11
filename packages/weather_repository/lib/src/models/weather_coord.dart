import 'package:json_annotation/json_annotation.dart';

part 'weather_coord.g.dart';

@JsonSerializable()
class Coord {
  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) =>
      _$CoordFromJson(json);

  final double? lon;
  final double? lat;

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}