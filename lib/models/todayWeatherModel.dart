import 'package:flutter/cupertino.dart';
import 'package:weather/domain/api_client.dart';
import 'package:weather/entity/today.dart';

class TodayWeatherModel extends ChangeNotifier {
  final apiClient = ApiClinets();
  TodayWeatherApi? _todayWeather;

  TodayWeatherApi? get todayWeather =>
      (_todayWeather == null) ? null : _todayWeather;

  Future<TodayWeatherApi> reloadTodayWeather() async {
    return await apiClient.getTodayWeather();
  }
}
