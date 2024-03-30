import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DioConfiguration {
  static Dio getInstance({bool cached = false}) {
    final dio = Dio();

    if (cached) {
      //* add logger interceptor
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
          ),
        ),
      );
      //* add cache interceptor
      dio.interceptors.add(
        DioCacheInterceptor(
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
        ),
      );
    }

    dio.options.contentType = 'application/json';
    return dio;
  }
}
