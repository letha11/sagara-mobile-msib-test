import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/dio_client.dart';
import 'package:weather_app/core/failures.dart';
import 'package:weather_app/data/model/current_day_forecast.dart';
import 'package:weather_app/data/model/multiple_days_forecast.dart';
import 'package:weather_app/util/constants.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentDayForecast>> getCurrentWeather(String city);
  Future<Either<Failure, MultipleDaysForecast>> getMultipleDaysWeather(String city);
}

class WeatherRepositoryImpl extends WeatherRepository {
  final Dio _dio;

  WeatherRepositoryImpl({DioClient? dio}) : _dio = dio?.dio ?? DioClient().dio;

  @override
  Future<Either<Failure, CurrentDayForecast>> getCurrentWeather(String city) async {
    try {
      final response = await _dio.get(
        'weather',
        queryParameters: {
          'q': city,
          'appid': apiKey,
        },
      );

      return Right(CurrentDayForecast.fromJson(response.data));
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 404) return Left(NotFoundFailure());
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }

  @override
  Future<Either<Failure, MultipleDaysForecast>> getMultipleDaysWeather(String city) async {
    try {
      final response = await _dio.get(
        'forecast',
        queryParameters: {
          'q': city,
          'appid': apiKey,
        },
      );

      return Right(MultipleDaysForecast.fromJson(response.data));
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 404) return Left(NotFoundFailure());
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
