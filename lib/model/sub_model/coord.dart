import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  const Coord({
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json["lat"],
      lon: json["lon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };

  @override
  String toString() {
    return "$lat, $lon, ";
  }

  @override
  List<Object?> get props => [
        lat,
        lon,
      ];
}
