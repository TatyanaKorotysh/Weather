import 'package:json_annotation/json_annotation.dart';

part 'wind.g.dart';

@JsonSerializable()
class Wind {
  final double speed;
  final double deg;
  final double? gust;
  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
