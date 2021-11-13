import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/domain/api_client.dart';
import 'package:weather/entity/weather/today.dart';

class TodayWeatherModel extends ChangeNotifier {
  final apiClient = ApiClinets();
  TodayWeatherApi? _todayWeather;

  TodayWeatherApi? get todayWeather =>
      (_todayWeather == null) ? null : _todayWeather;

  Future<TodayWeatherApi> reloadTodayWeather(Placemark data) async {
    return await apiClient.getTodayWeather(data);
  }
}
