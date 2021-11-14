import 'dart:async';

import 'package:weather/entity/today/today.dart';
import 'package:weather/events/todayWeatherEvents.dart';
import 'package:weather/location/location.dart';
import 'package:weather/models/todayWeatherModel.dart';

class TodayWeatherBloc {
  final _todayWeatherStateController = StreamController<TodayWeatherApi>();
  StreamSink<TodayWeatherApi> get _todayWeatherStream =>
      _todayWeatherStateController.sink;
  Stream<TodayWeatherApi> get todayWeatherSink =>
      _todayWeatherStateController.stream;

  final _todayWeatherEventController = StreamController<TodatWeatherEvent>();
  Sink<TodatWeatherEvent> get todayWeatherEventSink =>
      _todayWeatherEventController.sink;

  TodayWeatherBloc() {
    _todayWeatherEventController.stream.listen(_eventToState);
  }

  void _eventToState(TodatWeatherEvent event) async {
    final loationData = await Location().getLocationData();

    final TodayWeatherModel model = TodayWeatherModel();
    final data = await model.reloadTodayWeather(loationData[0]);

    _todayWeatherStream.add(data);
  }

  void dispose() {
    _todayWeatherStateController.close();
    _todayWeatherEventController.close();
  }
}
