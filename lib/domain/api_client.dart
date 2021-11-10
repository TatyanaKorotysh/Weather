import 'dart:convert';
import 'dart:io';

import 'package:weather/entity/today.dart';

class ApiClinets {
  final client = HttpClient();

  Future<TodayWeatherApi> getTodayWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=73092b0d2461a51272dfb17a5eccf122');

    final request = await client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());

    return TodayWeatherApi.fromJson(json);
  }
}
