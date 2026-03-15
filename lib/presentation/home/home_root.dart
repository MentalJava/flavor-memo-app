import 'package:flavor_memo_app/presentation/home/home_action.dart';
import 'package:flavor_memo_app/presentation/home/home_screen.dart';
import 'package:flavor_memo_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeRoot extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeRoot({super.key, required this.viewModel});

  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.onAction(const HomeAction.loadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return HomeScreen(
          state: widget.viewModel.state,
          onAction: (action) {
            switch (action) {
              case AddPost():
                context.push('/add');
                break;
              case LoadPosts():
              case LogOut():
                widget.viewModel.onAction(action);
                break;
            }
          },
        );
      },
    );
  }
}
