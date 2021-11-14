// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastApi _$ForecastApiFromJson(Map<String, dynamic> json) => ForecastApi(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      // list: (json['list'] as List<dynamic>)
      //     .map((e) => ForecastList.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      list: groupBy(
          (json['list'] as List<dynamic>)
              .map((e) => ForecastList.fromJson(e as Map<String, dynamic>))
              .toList(), (ForecastList e) {
        return DateFormat('EEEE').format(e.dtTxt); //e.dtTxt.weekday;
      }),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastApiToJson(ForecastApi instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list,
      'city': instance.city,
    };
