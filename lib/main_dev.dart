import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'data/repository/mock_auth_repository_impl.dart';
import 'data/repository/mock_post_repository_impl.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.dev;
  final authRepository = MockAuthRepositoryImpl();
  final postRepository = MockPostRepositoryImpl();

  runApp(MyApp(authRepository: authRepository, postRepository: postRepository));
}
