import 'package:flutter_base_riverpod/shared/storage/local_storage_helper.dart';

class LocalStorageService {
  static const _authTokenKey = 'authToken';

  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';

  final _localStorage = LocalStorageManagement();

  Future<String> getAuthToken() async {
    return await _localStorage.getEncrypted(_authTokenKey) ?? '';
  }

  void setAuthToken(String token) {
    _localStorage.setEncrypted(_authTokenKey, token);
  }

  void resetKeys() {
    _localStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
