import 'package:weather/entity/clouds.dart';
import 'package:weather/entity/forecast/sys.dart';
import 'package:weather/entity/main.dart';
import 'package:weather/entity/weather.dart';
import 'package:weather/entity/wind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list.g.dart';

@JsonSerializable()
class ForecastList {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  @JsonKey(name: 'dt_txt')
  final DateTime dtTxt;
  ForecastList({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastList.fromJson(Map<String, dynamic> json) =>
      _$ForecastListFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListToJson(this);
}
