import 'package:flutter_base_riverpod/domain/usecase/auth_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/login_model.dart';
import '../../state/state.dart';

class AuthViewModel extends StateNotifier<State<LoginModel>> {
  final AuthLoginUseCase _authLoginUsecase;

  AuthViewModel(
    this._authLoginUsecase,
  ) : super(const State.init());

  login(
    final Map<String, dynamic> data,
    final Function(String newToken) updateTokenCallback,
  ) async {
    try {
      state = const State.loading();
      final todoList =
          await _authLoginUsecase.execute(data, updateTokenCallback);
      state = State.success(todoList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
