import 'package:get_it/get_it.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/core/connection.dart';
import 'package:weather_app/core/dio_client.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

final sl = GetIt.I;

void initializeServices() {
  // sl.registerLazySingleton<Connection>(() => Connection());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(),
  );
  sl.registerLazySingleton<Connection>(
    () => Connection(),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(dioClient: sl()),
  );

  sl.registerFactory(
    () => WeatherBloc(
      weatherRepository: sl(),
      connection: sl(),
    ),
  );
}
