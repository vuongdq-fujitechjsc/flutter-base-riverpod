import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final Ref _ref;

  RefreshTokenInterceptor(
    this._ref, {
    required Dio dioClient,
  }) : _dio = dioClient;

  String get TokenExpiredException => 'TokenExpiredException';

  @override
  Future<void> onError(
    DioException dioException,
    ErrorInterceptorHandler handler,
  ) async {
    if (dioException.response != null) {
      if (dioException.response!.data != null) {
        final headers =
            dioException.response!.data['headers'] as Map<String, dynamic>;

        final code = headers['code'] as String;
        if (code == TokenExpiredException) {
          final tokenDio = Dio()..options = _dio.options;

          // handle refresh token
          final newToken = 'newToken';

          final response = await _dio.request<Map<String, dynamic>>(
              dioException.requestOptions.path,
              data: dioException.requestOptions.data,
              cancelToken: dioException.requestOptions.cancelToken,
              options: Options(headers: <String, Object?>{
                'Authorization': 'Bearer $newToken'
              }));
        }
      }
    }
    return super.onError(dioException, handler);
  }

  Future<String?> _refreshTokenRequest({
    required DioException dioException,
    required ErrorInterceptorHandler handler,
    required Dio tokenDio,
    required Map<String, dynamic> data,
  }) async {
    return null;
  }
}
