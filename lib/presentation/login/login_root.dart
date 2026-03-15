import 'package:flavor_memo_app/presentation/login/login_screen.dart';
import 'package:flavor_memo_app/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginRoot extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginRoot({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return LoginScreen(
          state: viewModel.state,
          onAction: viewModel.onAction,
        );
      },
    );
  }
}
