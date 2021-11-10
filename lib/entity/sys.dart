import 'dart:convert';

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return Sys(
      type: type ?? this.type,
      id: id ?? this.id,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      type: map['type']?.toInt(),
      id: map['id']?.toInt(),
      country: map['country'],
      sunrise: map['sunrise']?.toInt(),
      sunset: map['sunset']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sys.fromJson(String source) => Sys.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Sys(type: $type, id: $id, country: $country, sunrise: $sunrise, sunset: $sunset)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Sys &&
      other.type == type &&
      other.id == id &&
      other.country == country &&
      other.sunrise == sunrise &&
      other.sunset == sunset;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      id.hashCode ^
      country.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode;
  }
}