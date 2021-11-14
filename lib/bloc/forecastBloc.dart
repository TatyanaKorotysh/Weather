import 'dart:async';
import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/events/forecastEvents.dart';
import 'package:weather/location/location.dart';
import 'package:weather/models/forecastModel.dart';

class ForecastBloc {
  final _forecastStateController = StreamController<ForecastApi>();
  StreamSink<ForecastApi> get _forecastSink => _forecastStateController.sink;
  Stream<ForecastApi> get forecastSink => _forecastStateController.stream;

  final _forecastEventController = StreamController<ForecastEvent>();
  Sink<ForecastEvent> get forecastEventSink => _forecastEventController.sink;

  ForecastBloc() {
    _forecastEventController.stream.listen(_eventToState);
  }

  void _eventToState(ForecastEvent event) async {
    final loationData = await Location().getLocationData();

    final ForecastModel model = ForecastModel();
    final data = await model.reloadForecast(loationData[0]);

    _forecastSink.add(data);
  }

  void dispose() {
    _forecastStateController.close();
    _forecastEventController.close();
  }
}
