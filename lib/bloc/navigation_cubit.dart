import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/pages/forecast.dart';
import 'package:weather/pages/today.dart';

class NavigationCubit extends Cubit<Widget> {
  NavigationCubit()
      : super(
          const Center(
            child: CircularProgressIndicator(),
          ),
        );

  void getTodayWeatherPage() => emit(const TodayWeather());
  void getForecastPage() => emit(const Forecast());
}
