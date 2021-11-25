import 'package:json_annotation/json_annotation.dart';
import 'package:weather/entity/clouds.dart';
import 'package:weather/entity/coord.dart';
import 'package:weather/entity/main.dart';
import 'package:weather/entity/today/sys.dart';
import 'package:weather/entity/weather.dart';
import 'package:weather/entity/wind.dart';

part 'today.g.dart';

@JsonSerializable()
class TodayWeatherApi {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
  final String? error;
  TodayWeatherApi({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
    this.error,
  });

  set error(String? mess) {
    error = mess;
  }

  factory TodayWeatherApi.fromJson(Map<String, dynamic> json) =>
      _$TodayWeatherApiFromJson(json);

  Map<String, dynamic> toJson() => _$TodayWeatherApiToJson(this);
}
