import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:weather/entity/today/today.dart';

class ShareWeatherCubit extends Cubit<void> {
  ShareWeatherCubit() : super(null);

  void shareWeather(TodayWeatherApi data) {
    String shareText =
        "Weather today, ${data.name}\n ${(data.main!.temp).toInt()}°C | ${data.weather![0].main}";
    Share.share(shareText);
  }
}
