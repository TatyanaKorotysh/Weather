import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/models/forecast_model.dart';
import 'package:weather/location/location.dart';

class ForecastCubit extends Cubit<ForecastApi?> {
  ForecastCubit() : super(null);

  Future<void> getForecastData() async {
    try {
      final loationData = await Location().getLocationData();

      final ForecastModel model = ForecastModel();
      final forecastData = await model.reloadForecast(loationData[0]);

      emit(forecastData);
    } catch (error) {
      final forecastData = ForecastApi(
          error:
              "Something is wrong. Please check your internet connection and location services.");
      emit(forecastData);
    }
  }
}
