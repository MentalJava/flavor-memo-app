import '../model/user.dart';

abstract interface class AuthRepository {
  Stream<User?> get userStatus;
  Future<User?> login(String email, String password);
  Future<void> logout();
  User? get currentUser;
}
