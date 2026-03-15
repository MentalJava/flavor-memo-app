import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  @override
  final bool isLoading;
  @override
  final String? errorMessage;

  LoginState({this.isLoading = false, this.errorMessage});
}
