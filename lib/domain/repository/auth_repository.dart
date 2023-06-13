import 'package:flutter_base_riverpod/data/model/login_model.dart';

abstract class AuthRepository{
  Future<LoginModel> login(
    final Map<String, dynamic> data,
    final Function(String newToken) updateTokenCallback,
  );

  // register

  // forgot password

  // refresh token
}