import 'package:dio/dio.dart';

import 'response_model.dart';

abstract class ApiInterface {
  const ApiInterface();

  Future<List<T>> getDataList<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  });

  Future<T> getDataObject<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  });

  Future<T> postData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> responseBody) converter,
  });

  Future<T> putData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> responseBody) converter,
  });

  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiredAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> responseBody) converter,
  });

  void cancelRequests({CancelToken? cancelToken});
}
