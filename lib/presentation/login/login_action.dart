import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_action.freezed.dart';

@freezed
sealed class LoginAction with _$LoginAction {
  const factory LoginAction.login(String email, String password) =
      LoginRequested;
}
