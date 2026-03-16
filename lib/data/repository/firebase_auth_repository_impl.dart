import 'package:flavor_memo_app/domain/model/user.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  @override
  Stream<User?> get userStatus => throw UnimplementedError();

  @override
  Future<User?> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  User? get currentUser => throw UnimplementedError();
}
