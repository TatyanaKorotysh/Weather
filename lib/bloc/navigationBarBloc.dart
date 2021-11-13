import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:weather/events/NavigationBarEvents.dart';
import 'package:weather/pages/forecast.dart';
import 'package:weather/pages/today.dart';

class NavigationBarBloc {
  final _navigationBarStateController = StreamController<Widget>();
  StreamSink<Widget> get _navigationBarStream =>
      _navigationBarStateController.sink;
  Stream<Widget> get navigationBarSink => _navigationBarStateController.stream;

  final _navigationBarEventController = StreamController<NavigationBarEvent>();
  Sink<NavigationBarEvent> get navigationBarEventSink =>
      _navigationBarEventController.sink;

  NavigationBarBloc() {
    _navigationBarEventController.stream.listen(_eventToState);
  }

  void _eventToState(NavigationBarEvent event) async {
    switch (event.runtimeType) {
      case RouteToTodayWeatherEvent:
        _navigationBarStream.add(Today());
        break;
      case RouteToForecastWeatherEvent:
        _navigationBarStream.add(Forecast());
        break;
    }
  }

  void dispose() {
    _navigationBarStateController.close();
    _navigationBarEventController.close();
  }
}
