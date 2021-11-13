import 'package:weather/entity/forecast/list.dart';

import 'city.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class ForecastApi {
  final String cod;
  final int message;
  final int cnt;
  final List<ForecastList> list;
  final City city;
  ForecastApi({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ForecastApi.fromJson(Map<String, dynamic> json) =>
      _$ForecastApiFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastApiToJson(this);
}
