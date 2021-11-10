import 'dart:convert';

class Main {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int humidity;
  final int sea_level;
  final int grnd_level;
  Main({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
    required this.sea_level,
    required this.grnd_level,
  });

  Main copyWith({
    double? temp,
    double? feels_like,
    double? temp_min,
    double? temp_max,
    int? pressure,
    int? humidity,
    int? sea_level,
    int? grnd_level,
  }) {
    return Main(
      temp: temp ?? this.temp,
      feels_like: feels_like ?? this.feels_like,
      temp_min: temp_min ?? this.temp_min,
      temp_max: temp_max ?? this.temp_max,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      sea_level: sea_level ?? this.sea_level,
      grnd_level: grnd_level ?? this.grnd_level,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feels_like,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': sea_level,
      'grnd_level': grnd_level,
    };
  }

  factory Main.fromMap(Map<String, dynamic> map) {
    return Main(
      temp: map['temp']?.toDouble(),
      feels_like: map['feels_like']?.toDouble(),
      temp_min: map['temp_min']?.toDouble(),
      temp_max: map['temp_max']?.toDouble(),
      pressure: map['pressure']?.toInt(),
      humidity: map['humidity']?.toInt(),
      sea_level: map['sea_level']?.toInt(),
      grnd_level: map['grnd_level']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Main.fromJson(String source) => Main.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Main(temp: $temp, feels_like: $feels_like, temp_min: $temp_min, temp_max: $temp_max, pressure: $pressure, humidity: $humidity, sea_level: $sea_level, grnd_level: $grnd_level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Main &&
      other.temp == temp &&
      other.feels_like == feels_like &&
      other.temp_min == temp_min &&
      other.temp_max == temp_max &&
      other.pressure == pressure &&
      other.humidity == humidity &&
      other.sea_level == sea_level &&
      other.grnd_level == grnd_level;
  }

  @override
  int get hashCode {
    return temp.hashCode ^
      feels_like.hashCode ^
      temp_min.hashCode ^
      temp_max.hashCode ^
      pressure.hashCode ^
      humidity.hashCode ^
      sea_level.hashCode ^
      grnd_level.hashCode;
  }
}