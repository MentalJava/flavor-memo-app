import 'package:flutter/foundation.dart';
import '../models/user.dart';

abstract interface class AuthRepository extends Listenable {
  Stream<User?> get userStatus;
  Future<User?> login(String email, String password);
  Future<void> logout();
  User? get currentUser;
}
