import 'package:flutter_riverpod/flutter_riverpod.dart';

// State
import '../../../data/model/login_model.dart';
import '../../../domain/domain_module.dart';
import '../../state/state.dart';
import 'auth_viewmodel.dart';

final authViewModelStateNotifierProvider = StateNotifierProvider.autoDispose<AuthViewModel, State<LoginModel>>(
  (ref){
  return AuthViewModel(
    ref.watch(getAuthLoginUseCaseProvider),
  );
});