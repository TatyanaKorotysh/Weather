// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastApi _$ForecastApiFromJson(Map<String, dynamic> json) => ForecastApi(
      cod: json['cod'] as String?,
      message: json['message'] as int?,
      cnt: json['cnt'] as int?,
      list: (json['list'] as Map<String, dynamic>?)?.map(
        (k, dynamic e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((dynamic e) =>
                    ForecastList.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ForecastApiToJson(ForecastApi instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list,
      'city': instance.city,
      'error': instance.error,
    };
