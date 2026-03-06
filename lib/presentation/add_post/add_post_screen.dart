import 'package:flavor_memo_app/presentation/add_post/add_post_action.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class AddPostScreen extends StatefulWidget {
  final AddPostState state;
  final Function(AddPostAction) onAction;

  const AddPostScreen({super.key, required this.state, required this.onAction});

  @override
  State<StatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton(
            onPressed: widget.state.isUploading
                ? null
                : () => widget.onAction(
                    AddPostAction.onUpload(_contentController.text),
                  ),
            child: const Text(
              '공유',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.state.isUploading) const LinearProgressIndicator(),
            GestureDetector(
              onTap: () => widget.onAction(const AddPostAction.onPickImage()),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.grey[200],
                  child: widget.state.imagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text('클릭하여 사진 선택'),
                          ],
                        )
                      : Image.file(
                          File(widget.state.imagePath!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: '문구 입력...',
                  border: InputBorder.none,
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
