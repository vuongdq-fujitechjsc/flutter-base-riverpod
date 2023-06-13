// Repositories
import '../repository/auth_repository.dart';

// Usecases
import 'auth_usecase.dart';

// Models
import 'package:flutter_base_riverpod/data/model/login_model.dart';

class AuthLoginUseCaseImpl implements AuthLoginUseCase {
  final AuthRepository _repository;

  const AuthLoginUseCaseImpl(this._repository);

  @override
  Future<LoginModel> execute(
    Map<String, dynamic> data,
    Function(String newToken) updateTokenCallback,
  ) => _repository.login(data, updateTokenCallback);
}