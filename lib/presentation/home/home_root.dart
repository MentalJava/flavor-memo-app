import 'package:flavor_memo_app/presentation/home/home_action.dart';
import 'package:flavor_memo_app/presentation/home/home_screen.dart';
import 'package:flavor_memo_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeRoot extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeRoot({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return HomeScreen(
          state: viewModel.state,
          onAction: (action) {
            switch (action) {
              case AddPost():
                context.push('/add');
                break;
              case LoadPosts():
                viewModel.onAction(action);
                break;
            }
          },
        );
      },
    );
  }
}
