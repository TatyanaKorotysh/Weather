import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/entity/today/today.dart';
import 'package:weather/models/today_weather_model.dart';
import 'package:weather/location/location.dart';

class TodayWeatherCubit extends Cubit<TodayWeatherApi?> {
  TodayWeatherCubit() : super(null);

  Future<void> getTodayWeatherData() async {
    try {
      final loationData = await Location().getLocationData();

      final TodayWeatherModel model = TodayWeatherModel();
      final todayWeatherData = await model.reloadTodayWeather(loationData[0]);

      emit(todayWeatherData);
    } catch (error) {
      addError(error);
    }
  }
}
