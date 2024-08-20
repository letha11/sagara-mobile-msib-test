import 'package:equatable/equatable.dart';

import 'sub_model/sub_model.dart';

class MultipleDaysForecast extends Equatable {
  const MultipleDaysForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  final String? cod;
  final int? message;
  final int? cnt;
  final List<ListForecast> list;
  final City? city;

  factory MultipleDaysForecast.fromJson(Map<String, dynamic> json) {
    return MultipleDaysForecast(
      cod: json["cod"],
      message: json["message"],
      cnt: json["cnt"],
      list: json["list"] == null ? [] : List<ListForecast>.from(json["list"]!.map((x) => ListForecast.fromJson(x))),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": list.map((x) => x.toJson()).toList(),
        "city": city?.toJson(),
      };

  @override
  String toString() {
    return "$cod, $message, $cnt, $list, $city, ";
  }

  @override
  List<Object?> get props => [
        cod,
        message,
        cnt,
        list,
        city,
      ];
}

class ListForecast extends Equatable {
  const ListForecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    required this.rain,
  });

  final int? dt;
  final WeatherConditions? main;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  final DateTime? dtTxt;
  final Rain? rain;

  factory ListForecast.fromJson(Map<String, dynamic> json) {
    return ListForecast(
      dt: json["dt"],
      main: json["main"] == null ? null : WeatherConditions.fromJson(json["main"]),
      weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
      clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
      wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
      visibility: json["visibility"],
      pop: json["pop"],
      sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
      dtTxt: DateTime.tryParse(json["dt_txt"] ?? ""),
      rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main?.toJson(),
        "weather": weather.map((x) => x.toJson()).toList(),
        "clouds": clouds?.toJson(),
        "wind": wind?.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys?.toJson(),
        "dt_txt": dtTxt?.toIso8601String(),
        "rain": rain?.toJson(),
      };

  @override
  String toString() {
    return "$dt, $main, $weather, $clouds, $wind, $visibility, $pop, $sys, $dtTxt, $rain, ";
  }

  @override
  List<Object?> get props => [
        dt,
        main,
        weather,
        clouds,
        wind,
        visibility,
        pop,
        sys,
        dtTxt,
        rain,
      ];
}

