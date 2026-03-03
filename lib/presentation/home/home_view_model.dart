import 'package:flutter/material.dart';
import '../../domain/models/post.dart';
import '../../domain/repository/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository _postRepository;

  HomeViewModel({required PostRepository postRepository})
    : _postRepository = postRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _posts = await _postRepository.getPosts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
