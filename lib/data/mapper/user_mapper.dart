import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/model/user.dart';

extension UserMapper on firebase_auth.User {
  User toUser() {
    return User(
      id: uid,
      email: email ?? '',
      displayName: displayName,
      photoUrl: photoURL,
    );
  }
}
