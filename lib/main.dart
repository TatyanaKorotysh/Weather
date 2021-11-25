import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/forecast_cubit.dart';
import 'package:weather/bloc/navigation_cubit.dart';
import 'package:weather/bloc/share_weather_cubit.dart';
import 'package:weather/bloc/today_weather_cubit.dart';
import 'package:weather/pages/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: BlocProvider<NavigationCubit>(
        create: (_) => NavigationCubit(),
        child: BlocProvider<TodayWeatherCubit>(
          create: (_) => TodayWeatherCubit(),
          child: BlocProvider<ForecastCubit>(
            create: (_) => ForecastCubit(),
            child: BlocProvider<ShareWeatherCubit>(
              create: (_) => ShareWeatherCubit(),
              child: const NavigationBar(),
            ),
          ),
        ),
      ),
    );
  }
}
