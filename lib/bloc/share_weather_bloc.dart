import 'dart:async';

import 'package:weather/entity/today/today.dart';
import 'package:weather/events/share_weather_events.dart';
import 'package:share/share.dart';

class ShareWeatherBloc {
  final _shareWeatherEventController = StreamController<ShareWeatherEvent>();
  Sink<ShareWeatherEvent> get shareWeatherEventSink =>
      _shareWeatherEventController.sink;

  ShareWeatherBloc() {
    _shareWeatherEventController.stream.listen(_eventToState);
  }

  void _eventToState(ShareWeatherEvent event) async {
    TodayWeatherApi data = event.shareData;
    String shareText =
        "Weather today, ${data.name}\n ${(data.main.temp).toInt()}°C | ${data.weather[0].main}";
    Share.share(shareText);
  }

  void dispose() {
    _shareWeatherEventController.close();
  }
}
