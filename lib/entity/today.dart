import 'dart:convert';

import 'package:collection/collection.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

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

  TodayWeatherApi copyWith({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) {
    return TodayWeatherApi(
      coord: coord ?? this.coord,
      weather: weather ?? this.weather,
      base: base ?? this.base,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      timezone: timezone ?? this.timezone,
      id: id ?? this.id,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coord': coord.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'base': base,
      'main': main.toMap(),
      'visibility': visibility,
      'wind': wind.toMap(),
      'clouds': clouds.toMap(),
      'dt': dt,
      'sys': sys.toMap(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }

  factory TodayWeatherApi.fromMap(Map<String, dynamic> map) {
    return TodayWeatherApi(
      coord: Coord.fromMap(map['coord']),
      weather:
          List<Weather>.from(map['weather']?.map((x) => Weather.fromMap(x))),
      base: map['base'],
      main: Main.fromMap(map['main']),
      visibility: map['visibility']?.toInt(),
      wind: Wind.fromMap(map['wind']),
      clouds: Clouds.fromMap(map['clouds']),
      dt: map['dt']?.toInt(),
      sys: Sys.fromMap(map['sys']),
      timezone: map['timezone']?.toInt(),
      id: map['id']?.toInt(),
      name: map['name'],
      cod: map['cod']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayWeatherApi.fromJson(String source) =>
      TodayWeatherApi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodayWeatherApi(coord: $coord, weather: $weather, base: $base, main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, cod: $cod)';
  }
}
