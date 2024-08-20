import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/connection.dart';
import 'package:weather_app/core/failures.dart';
import 'package:weather_app/core/geolocation.dart';
import 'package:weather_app/data/model/current_day_forecast.dart';
import 'package:weather_app/data/model/multiple_days_forecast.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  final Connection _connection;
  final String defaultCity = "Jakarta";
  Position? position;

  WeatherBloc({WeatherRepository? weatherRepository, Connection? connection})
      : _weatherRepository = weatherRepository ?? WeatherRepositoryImpl(),
        _connection = connection ?? Connection(),
        super(WeatherInitial()) {
    on<GetWeather>(_onGetBothWeather);
  }

  void _onGetBothWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      position = await Geolocation.determinePosition();
    } catch (e) {
      debugPrint('user doesn\'t allow location');
    }

    final userHasConnection = await _connection.checkConnection();
    if (!userHasConnection) {
      emit(const WeatherError(
        errorMessage:
            "No internet connection, check your connection then try again",
      ));
      return;
    }

    late Either<Failure, CurrentDayForecast> currentWeather;
    late Either<Failure, MultipleDaysForecast> forecastWeather;
    if (position != null) {
      currentWeather = await _weatherRepository.getCurrentWeather(
        lat: position!.latitude,
        lon: position!.longitude,
      );
      forecastWeather = await _weatherRepository.getMultipleDaysWeather(
        lat: position!.latitude,
        lon: position!.longitude,
      );
    } else {
      currentWeather = await _weatherRepository.getCurrentWeather(
          city: event.city ?? defaultCity);
      forecastWeather = await _weatherRepository.getMultipleDaysWeather(
          city: event.city ?? defaultCity);
    }

    currentWeather.fold(
      (failure) {
        if (failure is NotFoundFailure) {
          emit(WeatherError(errorMessage: "City not found", failure: failure));
        } else if (failure is TimeoutFailure) {
          emit(WeatherError(
              errorMessage: "Request timed out, try again", failure: failure));
        } else if (failure is UnhandledFailure) {
          emit(WeatherError(
              errorMessage: "An error occurred", failure: failure));
        }
      },
      (currentDayForecast) => forecastWeather.fold(
        (failure) {
          if (failure is NotFoundFailure) {
            emit(
                WeatherError(errorMessage: "City not found", failure: failure));
          } else if (failure is TimeoutFailure) {
            emit(WeatherError(
                errorMessage: "Request timed out, try again",
                failure: failure));
          } else if (failure is UnhandledFailure) {
            emit(WeatherError(
                errorMessage: "An error occurred", failure: failure));
          }
        },
        (multipleDaysForecast) =>
            emit(WeatherLoaded(currentDayForecast, multipleDaysForecast)),
      ),
    );
  }
}
