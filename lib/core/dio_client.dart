import 'package:dio/dio.dart';
import 'package:weather_app/utils/constants.dart';

class DioClient {
  late final Dio _dio;

  final _options = BaseOptions(
    baseUrl: baseUrl,
  );

  DioClient({
    Dio? dio,
  }) {
    _dio = dio ?? Dio(_options);
    _dio.interceptors.add(_acceptJsonOnlyInterceptor());
  }

  InterceptorsWrapper _acceptJsonOnlyInterceptor() =>
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      });

  Dio get dio => _dio;
}
