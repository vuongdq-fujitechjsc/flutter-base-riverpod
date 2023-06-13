// Repositories
import 'package:flutter_base_riverpod/domain/repository/auth_repository.dart';

// Models
import 'package:flutter_base_riverpod/data/model/login_model.dart';

// Services
import '../networking/api_service.dart';

class AuthRepositoryImpl implements AuthRepository{
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);
  
  @override
  Future<LoginModel> login(
    final Map<String, dynamic> data,
    final Function(String newToken) updateTokenCallback,
  ) async {
    return await _apiService.postData<LoginModel>(
      endpoint: '/login',
      data: data,
      requiredAuthToken: false,
      converter: (response) {
        updateTokenCallback(response.body['access_token'] as String);
        return LoginModel.fromJson(response.body);
      },
    );
  }
}