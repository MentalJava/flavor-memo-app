import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:flavor_memo_app/presentation/login/login_action.dart';
import 'package:flavor_memo_app/presentation/login/login_state.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository authRepository;

  LoginViewModel({required this.authRepository});

  LoginState _state = LoginState();
  LoginState get state => _state;

  void onAction(LoginAction action) {
    switch (action) {
      case LoginRequested(:final email, :final password):
        _login(email, password);
        break;
    }
  }

  Future<void> _login(String email, String password) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      await authRepository.login(email, password);
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString());
    } finally {
      // If login succeeds, GoRouter will redirect.
      // If fails, we stop loading and show error.
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
