import 'dart:async';

import 'package:flavor_memo_app/domain/model/post.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:flavor_memo_app/domain/repository/post_repository.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_action.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_event.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final PostRepository postRepository;
  final _picker = ImagePicker();

  final _eventController = StreamController<AddPostEvent>.broadcast();
  Stream<AddPostEvent> get eventStream => _eventController.stream;

  AddPostState _state = const AddPostState();
  AddPostState get state => _state;

  AddPostViewModel({
    required this.authRepository,
    required this.postRepository,
  });

  Future<void> onAction(AddPostAction action) async {
    switch (action) {
      case OnPickImage():
        _onPickImage();
        break;
      case OnUpload():
        final result = await _onUpload(action.content);
        if (result) {
          _eventController.add(const AddPostEvent.successUploadImage());
        }
        break;
    }
  }

  Future<void> _onPickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _state = _state.copyWith(imagePath: pickedFile.path);
    }
    notifyListeners();
  }

  Future<bool> _onUpload(String content) async {
    if (_state.imagePath == null) {
      return false;
    }
    _state = _state.copyWith(isUploading: true);
    notifyListeners();
    try {
      final user = authRepository.currentUser;
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user?.id ?? 'anonymous',
        imagePath: _state.imagePath!,
        caption: content,
        createdAt: DateTime.now(),
      );
      await postRepository.addPost(newPost);
    } catch (e) {
      _state = _state.copyWith(isUploading: false);
      notifyListeners();
    }
    return true;
  }
}
