import 'package:json_annotation/json_annotation.dart';
import 'package:weather/entity/clouds.dart';
import 'package:weather/entity/coord.dart';
import 'package:weather/entity/main.dart';
import 'package:weather/entity/weather.dart';
import 'package:weather/entity/weather/sys.dart';
import 'package:weather/entity/wind.dart';

part 'today.g.dart';

@JsonSerializable()
class TodayWeatherApi {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  TodayWeatherApi({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory TodayWeatherApi.fromJson(Map<String, dynamic> json) =>
      _$TodayWeatherApiFromJson(json);

  Map<String, dynamic> toJson() => _$TodayWeatherApiToJson(this);
}
