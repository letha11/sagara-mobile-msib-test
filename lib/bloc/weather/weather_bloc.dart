import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/failures.dart';
import 'package:weather_app/data/model/current_day_forecast.dart';
import 'package:weather_app/data/model/multiple_days_forecast.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

// FIXME: handle tidak ada koneksi
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepositoryImpl(),
        super(WeatherInitial()) {
    on<GetBothWeather>(_onGetBothWeather);
  }

  void _onGetBothWeather(GetBothWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final currentWeather = await _weatherRepository.getCurrentWeather(event.city);
    final forecastWeather = await _weatherRepository.getMultipleDaysWeather(event.city);

    currentWeather.fold(
      (failure) {
        if (failure is NotFoundFailure) {
          emit(WeatherError(errorMessage: "City not found", failure: failure));
        } else if (failure is TimeoutFailure) {
          emit(WeatherError(errorMessage: "Request timed out, try again", failure: failure));
        } else {
          emit(WeatherError(errorMessage: "An error occurred", failure: failure));
        }
      },
      (currentDayForecast) => forecastWeather.fold(
        (failure) {

          if (failure is NotFoundFailure) {
            emit(WeatherError(errorMessage: "City not found", failure: failure));
          } else if (failure is TimeoutFailure) {
            emit(WeatherError(errorMessage: "Request timed out, try again", failure: failure));
          } else {
            emit(WeatherError(errorMessage: "An error occurred", failure: failure));
          }

        },
        (multipleDaysForecast) => emit(WeatherLoaded(currentDayForecast, multipleDaysForecast)),
      ),
    );
  }
}
