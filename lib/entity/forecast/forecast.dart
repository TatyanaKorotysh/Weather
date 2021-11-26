import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:weather/entity/forecast/list.dart';

import 'city.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class ForecastApi {
  final String? cod;
  final int? message;
  final int? cnt;
  final Map<String, List<ForecastList>>? list;
  final City? city;
  final String? error;
  ForecastApi({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
    this.error,
  });

  set error(String? mess) {
    error = mess;
  }

  factory ForecastApi.fromJson(Map<String, dynamic> json) =>
      _$ForecastApiFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastApiToJson(this);
}
