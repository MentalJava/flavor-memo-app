import 'package:flavor_memo_app/presentation/add_post/add_post_event.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_screen.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_view_model.dart';
import 'package:flutter/material.dart';

class AddPostRoot extends StatefulWidget {
  final AddPostViewModel viewModel;

  const AddPostRoot({super.key, required this.viewModel});

  @override
  State<AddPostRoot> createState() => _AddPostRootState();
}

class _AddPostRootState extends State<AddPostRoot> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.eventStream.listen((event) {
      if (event is SuccessUploadImage) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return AddPostScreen(
          state: widget.viewModel.state,
          onAction: widget.viewModel.onAction,
        );
      },
    );
  }
}
