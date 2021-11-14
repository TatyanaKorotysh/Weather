import 'package:weather/entity/today/today.dart';

abstract class ShareWeatherEvent {
  final TodayWeatherApi shareData;

  ShareWeatherEvent({required this.shareData});
}

class SendWeatherAsTextEvent extends ShareWeatherEvent {
  @override
  final TodayWeatherApi shareData;

  SendWeatherAsTextEvent({required this.shareData})
      : super(shareData: shareData);
}
