part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

final class GetWeather extends WeatherEvent {
  final String? city;

  const GetWeather({this.city});

  @override
  List<Object?> get props => [city];
}
