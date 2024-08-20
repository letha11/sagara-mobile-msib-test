import 'package:equatable/equatable.dart';

import 'coord.dart';

class City extends Equatable {
  const City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name: json["name"],
      coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      country: json["country"],
      population: json["population"],
      timezone: json["timezone"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord?.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };

  @override
  String toString() {
    return "$id, $name, $coord, $country, $population, $timezone, $sunrise, $sunset, ";
  }

  @override
  List<Object?> get props => [
        id,
        name,
        coord,
        country,
        population,
        timezone,
        sunrise,
        sunset,
      ];
}
