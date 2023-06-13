import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_base_riverpod/data/networking/api_interface.dart';
import 'package:flutter_base_riverpod/data/networking/dio_service.dart';

import 'package:flutter_base_riverpod/data/networking/dio_exception.dart';

import 'response_model.dart';

class ApiService implements ApiInterface {
  late final DioService _dioService;

  ApiService(DioService dioService) : _dioService = dioService;

  @override
  Future<List<T>> getDataList<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiredAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  }) async {
    List<Object?> body;

    try {
      final data = await _dioService.get<List<Object?>>(
          endpoint: endpoint,
          cacheOptions: _dioService.globalCacheOptions?.copyWith(
            policy: cachePolicy,
            maxStale: cacheAgeDays != null
                ? Nullable(Duration(days: cacheAgeDays))
                : null,
          ),
          options: Options(
            extra: <String, Object?>{
              'requiredAuthToken': requiredAuthToken,
            },
          ),
          params: params,
          cancelToken: cancelToken);
      body = data.body;
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return body
          .map((dataMap) => converter(dataMap! as Map<String, dynamic>))
          .toList();
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> getDataObject<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiredAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  }) async {
    Map<String, dynamic> body;
    try {
      final data = await _dioService.get<Map<String, dynamic>>(
        endpoint: endpoint,
        params: params,
        cacheOptions: _dioService.globalCacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null
              ? Nullable(Duration(days: cacheAgeDays))
              : null,
        ),
        options: Options(
          extra: <String, Object?>{
            'requiredAuthToken': requiredAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );

      body = data.body;
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return converter(body);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> postData<T>({
    required String endpoint,
    required Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) converter,
  }) async {
    ResponseModel<Map<String, dynamic>> response;

    try {
      response = await _dioService.post<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiredAuthToken': requiredAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> putData<T>({
    required String endpoint,
    required Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) converter,
  }) async {
    ResponseModel<Map<String, dynamic>> response;

    try {
      response = await _dioService.post<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiredAuthToken': requiredAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) converter,
  }) async {
    ResponseModel<Map<String, dynamic>> response;

    try {
      response = await _dioService.post<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiredAuthToken': requiredAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return converter(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }
}
