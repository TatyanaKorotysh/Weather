import 'dart:async';
import 'package:collection/collection.dart';
import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/entity/forecast/list.dart';
import 'package:weather/events/forecastEvents.dart';
import 'package:weather/location/location.dart';
import 'package:weather/models/forecastModel.dart';

class ForecastBloc {
  final _forecastStateController = StreamController<ForecastApi>();
  StreamSink<ForecastApi> get _forecastStream => _forecastStateController.sink;
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
    //data.list = _groupForecastList(data.list);

    _forecastStream.add(data);
  }

  void dispose() {
    _forecastStateController.close();
    _forecastEventController.close();
  }

  Map<int, List<ForecastList>> _groupForecastList(List<ForecastList> data) {
    final groups = groupBy(data, (ForecastList e) {
      return e.dtTxt.weekday;
    });

    return groups;
  }
}
