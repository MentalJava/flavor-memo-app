import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'data/repositories/mock_auth_repository.dart';
import 'data/repositories/mock_post_repository.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.staging;
  final authRepository = MockAuthRepository();
  final postRepository = MockPostRepository();

  runApp(MyApp(authRepository: authRepository, postRepository: postRepository));
}
