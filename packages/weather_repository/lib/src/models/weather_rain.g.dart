// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_rain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rain _$RainFromJson(Map<String, dynamic> json) => Rain(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RainToJson(Rain instance) => <String, dynamic>{
      '1h': instance.oneHour,
    };
