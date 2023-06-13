import 'package:dio/dio.dart';

enum _ExceptionType {
  // token
  TokenExpiredException,

  // cancel
  cancelException,

  // timeout
  connectTimeoutException,
  sendTimeoutException,
  receiveTimeoutException,

  // request
  apiException,
  formatException,
  connectionError,

  // others
  unrecognizedException,
  serializationException
}

class CustomException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final _ExceptionType exceptionType;

  CustomException({
    this.code,
    int? statusCode,
    required this.message,
    this.exceptionType = _ExceptionType.apiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory CustomException.fromDioException(Exception error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return CustomException(
                message: 'Request cancelled',
                statusCode: error.response?.statusCode,
                exceptionType: _ExceptionType.cancelException);
          case DioExceptionType.connectionError:
            return CustomException(
              message: 'Connection error',
              statusCode: error.response?.statusCode,
              exceptionType: _ExceptionType.connectionError,
            );
          case DioExceptionType.connectionTimeout:
            return CustomException(
              message: 'Connection timeout',
              statusCode: error.response?.statusCode,
              exceptionType: _ExceptionType.connectTimeoutException,
            );
          case DioExceptionType.sendTimeout:
            return CustomException(
              message: 'Send timeout',
              statusCode: error.response?.statusCode,
              exceptionType: _ExceptionType.sendTimeoutException,
            );
          case DioExceptionType.receiveTimeout:
            return CustomException(
              message: 'Receive timeout',
              statusCode: error.response?.statusCode,
              exceptionType: _ExceptionType.receiveTimeoutException,
            );
          case DioExceptionType.badCertificate:
          case DioExceptionType.badResponse:
          case DioExceptionType.unknown:
            final code = error.response?.data['headers']['code'] as String;
            final message =
                error.response?.data['headers']['message'] as String;
            return CustomException(
              message: message,
              code: code,
              statusCode: error.response?.statusCode,
              exceptionType: _ExceptionType.TokenExpiredException,
            );
        }
      } else {
        return CustomException(
          message: 'Error unrecognized',
          exceptionType: _ExceptionType.unrecognizedException,
        );
      }
    } on FormatException catch (e) {
      return CustomException(
        message: e.message,
        exceptionType: _ExceptionType.formatException,
      );
    } on Exception catch (_) {
      return CustomException(
        message: 'Error unrecognized',
        exceptionType: _ExceptionType.unrecognizedException,
      );
    }
  }

  factory CustomException.fromParsingException(Exception error) {
    // Logging for print stack trace
    print('$error');
    return CustomException(
        message: 'Failed to parse response',
        exceptionType: _ExceptionType.serializationException);
  }
}
