import 'package:flavor_memo_app/domain/model/user.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import '../mapper/user_mapper.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepositoryImpl(this._auth);

  @override
  Stream<User?> get userStatus => throw UnimplementedError();

  @override
  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user?.toUser();
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  User? get currentUser => throw UnimplementedError();
}
