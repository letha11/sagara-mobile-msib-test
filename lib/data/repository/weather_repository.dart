import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/dio_client.dart';
import 'package:weather_app/core/failures.dart';
import 'package:weather_app/data/model/current_day_forecast.dart';
import 'package:weather_app/data/model/multiple_days_forecast.dart';
import 'package:weather_app/utils/constants.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentDayForecast>> getCurrentWeather({
    String? city,
    double? lat,
    double? lon,
  });
  Future<Either<Failure, MultipleDaysForecast>> getMultipleDaysWeather({
    String city,
    double? lat,
    double? lon,
  });
}

class WeatherRepositoryImpl extends WeatherRepository {
  final DioClient _dioClient;

  WeatherRepositoryImpl({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  @override
  Future<Either<Failure, CurrentDayForecast>> getCurrentWeather({String? city, double? lat, double? lon}) async {
    try {
      final response = await _dioClient.dio.get(
        '/weather',
        queryParameters: {
          'q': city,
          'lat': lat,
          'lon': lon,
          'units': 'metric',
          'appid': apiKey,
        },
      );

      return Right(CurrentDayForecast.fromJson(response.data));
    } on DioException catch (e, stacktrace) {
      final response = e.response;

      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      if (response?.statusCode == 404) return Left(NotFoundFailure());
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      return Left(UnhandledFailure(e));
    }
  }

  @override
  Future<Either<Failure, MultipleDaysForecast>> getMultipleDaysWeather({
    String? city,
    double? lat,
    double? lon,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/forecast',
        queryParameters: {
          'q': city,
          'lat': lat,
          'lon': lon,
          'units': 'metric',
          'appid': apiKey,
        },
      );

      return Right(MultipleDaysForecast.fromJson(response.data));
    } on DioException catch (e, stacktrace) {
      final response = e.response;

      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      if (response?.statusCode == 404) return Left(NotFoundFailure());
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      return Left(UnhandledFailure(e));
    }
  }
}
