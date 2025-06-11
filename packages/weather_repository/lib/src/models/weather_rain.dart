import 'package:json_annotation/json_annotation.dart';

part 'weather_rain.g.dart';

@JsonSerializable()
class Rain {
  Rain({this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  @JsonKey(name: '1h')
  final double? oneHour;

  Map<String, dynamic> toJson() => _$RainToJson(this);
}
