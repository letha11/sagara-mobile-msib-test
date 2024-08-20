part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final CurrentDayForecast currentDayForecast;
  final MultipleDaysForecast multipleDaysForecast;

  const WeatherLoaded(this.currentDayForecast, this.multipleDaysForecast);

  @override
  List<Object> get props => [currentDayForecast, multipleDaysForecast];
}


final class WeatherError extends WeatherState {
  final Failure? failure;
  final String errorMessage;

  const WeatherError({this.failure, required this.errorMessage});

  @override
  List<Object?> get props => [failure, errorMessage];
}
