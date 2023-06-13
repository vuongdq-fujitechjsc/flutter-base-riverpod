import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_base_riverpod/shared/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Services
import 'package:flutter_base_riverpod/shared/storage/local_storage_service.dart';
import 'package:flutter_base_riverpod/data/networking/api_service.dart';
import 'package:flutter_base_riverpod/data/networking/dio_service.dart';

// Interceptor
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_base_riverpod/data/networking/refresh_token_interceptor.dart';

final localStorageServiceProvider = Provider<LocalStorageService>(
  (ref) => LocalStorageService(),
);
final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(baseUrl: 'http://192.168.100.164:3000' //
      );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final _dio = ref.watch(_dioProvider);
  final _cacheOptions = CacheOptions(
    store: HiveCacheStore(LocalStorageProvider.path),
    policy: CachePolicy.noCache,
    maxStale: const Duration(days: 30),
    keyBuilder: (options) => options.path,
  );
  final debugMode = true;
  return DioService(
      dioClient: _dio,
      globalCacheOptions: _cacheOptions,
      interceptors: [
        // Important level base on order
        DioCacheInterceptor(options: _cacheOptions),
        //check debugMode
        if (debugMode)
          PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 90),
        RefreshTokenInterceptor(ref, dioClient: _dio),
      ]);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final _dioService = ref.watch(_dioServiceProvider);
  return ApiService(_dioService);
});
