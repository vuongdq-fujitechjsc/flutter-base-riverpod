import 'package:flutter_base_riverpod/shared/utils/app_utils.dart';

class ResponseModel<T> {
  final _ResponseHeaderModel headers;
  final T body;

  const ResponseModel({
    required this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        headers: _ResponseHeaderModel.fromJson(
            json['header'] as Map<String, dynamic>),
        body: json['body'] as T);
  }
}

class _ResponseHeaderModel {
  final bool error;
  final String message;
  final String? code;

  const _ResponseHeaderModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory _ResponseHeaderModel.fromJson(Map<String, dynamic> json) {
    return _ResponseHeaderModel(
        error: AppUtils.boolFromInt(json['error'] as int),
        message: json['message'] as String,
        code: json['code'] as String);
  }
}
