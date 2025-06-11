import 'package:json_annotation/json_annotation.dart';

part 'weather_main_data.g.dart';

@JsonSerializable()
class MainWeatherData {
  MainWeatherData({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory MainWeatherData.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherDataFromJson(json);

  @JsonKey(name: 'temp')
  final double? temp;

  @JsonKey(name: 'feels_like')
  final double? feelsLike;

  @JsonKey(name: 'temp_min')
  final double? tempMin;

  @JsonKey(name: 'temp_max')
  final double? tempMax;

  @JsonKey(name: 'pressure')
  final int? pressure;

  @JsonKey(name: 'humidity')
  final int? humidity;

  @JsonKey(name: 'sea_level')
  final int? seaLevel;

  @JsonKey(name: 'grnd_level')
  final int? grndLevel;

  Map<String, dynamic> toJson() => _$MainWeatherDataToJson(this);
}
