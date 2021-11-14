import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/domain/api_client.dart';
import 'package:weather/entity/forecast/forecast.dart';

class ForecastModel extends ChangeNotifier {
  final apiClient = ApiClinets();
  ForecastApi? _todayWeather;

  ForecastApi? get forecast => (_todayWeather == null) ? null : _todayWeather;

  Future<ForecastApi> reloadForecast(Placemark data) async {
    return await apiClient.getForecast(data);
  }
}
