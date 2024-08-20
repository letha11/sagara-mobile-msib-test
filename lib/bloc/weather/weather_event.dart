part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class GetBothWeather extends WeatherEvent {
  final String city;

  const GetBothWeather(this.city);

  @override
  List<Object> get props => [city];
}

// final class GetCurrentWeather extends WeatherEvent {
//   final String city;
//
//   const GetCurrentWeather(this.city);
//
//   @override
//   List<Object> get props => [city];
// }
//
// final class GetForecastWeather extends WeatherEvent {
//   final String city;
//
//   const GetForecastWeather(this.city);
//
//   @override
//   List<Object> get props => [city];
// }
