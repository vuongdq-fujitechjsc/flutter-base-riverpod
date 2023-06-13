import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
    const factory LoginModel({
        String? status,
        String? token,
        String? refreshToken,
    }) = _LoginModel;

    factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
}
