import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/auth_repository.dart';

class MockAuthRepositoryImpl extends ChangeNotifier implements AuthRepository {
  final _controller = StreamController<User?>.broadcast();
  User? _user;

  @override
  Stream<User?> get userStatus => _controller.stream;

  @override
  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // 특정 테스트 계정 검증 (test@sns.com / 1234)
    if (email == 'test@sns.com' && password == '1234') {
      _user = User(id: '1', email: email, displayName: 'Test User');
      _controller.add(_user);
      notifyListeners(); // GoRouter에 상태 변경 알림
      return _user;
    } else {
      throw Exception('이메일 또는 비밀번호가 틀렸습니다. (힌트: test@sns.com / 1234)');
    }
  }

  @override
  Future<void> logout() async {
    _user = null;
    _controller.add(null);
    notifyListeners();
  }

  @override
  User? get currentUser => _user;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
