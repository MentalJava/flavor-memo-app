import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:flavor_memo_app/presentation/home/home_action.dart';
import 'package:flavor_memo_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';
import '../../domain/repository/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository postRepository;
  final AuthRepository authRepository;

  HomeViewModel({required this.postRepository, required this.authRepository});

  HomeState _state = const HomeState();
  HomeState get state => _state;

  void onAction(HomeAction action) {
    action.when(loadPosts: fetchPosts, addPost: () => _addPost());
  }

  Future<void> fetchPosts() async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final posts = await postRepository.getPosts();
      _state = _state.copyWith(posts: posts);
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString());
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _logOut() async {
    try {
      await authRepository.logout();
    } catch (e) {
      _state = _state.copyWith(errorMessage: '로그아웃 실패: $e');
      notifyListeners();
    }
  }

  void _addPost() {}
}
