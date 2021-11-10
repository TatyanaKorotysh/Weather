import 'dart:convert';

class Coord {
  final double lon;
  final double lat;
  Coord({
    required this.lon,
    required this.lat,
  });

  Coord copyWith({
    double? lon,
    double? lat,
  }) {
    return Coord(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lon: map['lon']?.toDouble(),
      lat: map['lat']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coord.fromJson(String source) => Coord.fromMap(json.decode(source));

  @override
  String toString() => 'Coord(lon: $lon, lat: $lat)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Coord &&
      other.lon == lon &&
      other.lat == lat;
  }

  @override
  int get hashCode => lon.hashCode ^ lat.hashCode;
}