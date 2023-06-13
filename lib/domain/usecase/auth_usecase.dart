import '../../data/model/login_model.dart';

abstract class AuthLoginUseCase {
  Future<LoginModel> execute(
    final Map<String, dynamic> data,
    final Function(String newToken) updateTokenCallback,
  );
}