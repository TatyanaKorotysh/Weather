import 'dart:convert';
import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/entity/weather/today.dart';

class ApiClinets {
  final client = HttpClient();

  Future<TodayWeatherApi> getTodayWeather(Placemark data) async {
    final locality = data.locality.toString().replaceAll(' ', '%20');
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=' +
        locality +
        '&appid=73092b0d2461a51272dfb17a5eccf122');

    final request = await client.getUrl(url);
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    return TodayWeatherApi.fromJson(json);
  }

  Future<ForecastApi> getForecast(Placemark data) async {
    final locality = data.locality.toString().replaceAll(' ', '%20');
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=' +
            locality +
            '&appid=73092b0d2461a51272dfb17a5eccf122');

    final request = await client.getUrl(url);
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    return ForecastApi.fromJson(json);
  }
}

extension ApiClinetsResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
