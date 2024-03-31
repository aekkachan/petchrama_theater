import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DioConfiguration {
  static Dio getInstance({bool cached = false}) {
    //* use TalkerDioLogger to logger http request detail
    var loggerInterceptor = TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    );

    //* use DioCacheInterceptor to persist cache
    var cacheInterceptor = DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(maxSize: 51200, maxEntrySize: 5120),
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(hours: 2),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      ),
    );

    //* use DioCacheInterceptor to set header and send token
    var wrapperInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          'accept': 'application/json',
          'Authorization': Apis.token,
        });
        return handler.next(options);
      },
    );

    final dio = Dio();
    //* add logger interceptor
    dio.interceptors.add(loggerInterceptor);
    // * add wrapper interceptor
    dio.interceptors.add(wrapperInterceptor);

    if (cached) {
      //* add cache interceptor
      dio.interceptors.add(cacheInterceptor);
    }

    return dio;
  }
}
