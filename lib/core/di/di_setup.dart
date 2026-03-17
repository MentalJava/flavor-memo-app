import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_memo_app/data/repository/firebase_auth_repository_impl.dart';
import 'package:flavor_memo_app/data/repository/firestore_post_repository_impl.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_view_model.dart';
import 'package:flavor_memo_app/presentation/login/login_view_model.dart';
import 'package:get_it/get_it.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/post_repository.dart';
import '../../data/repository/mock_auth_repository_impl.dart';
import '../../data/repository/mock_post_repository_impl.dart';
import '../../presentation/home/home_view_model.dart';
import '../config/flavor_config.dart';

final getIt = GetIt.instance;

void setupDI() {
  _registerRepositories();
  _registerViewModels();
}

void _registerRepositories() {
  final flavor = FlavorConfig.appFlavor;

  switch (flavor) {
    case Flavor.prod:
      // Prod: 실제 Firebase 서버 연동
      getIt.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepositoryImpl(FirebaseAuth.instance),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => FirestorePostRepositoryImpl(FirebaseFirestore.instance),
      );
      break;

    case Flavor.staging:
      // Staging: Firebase Emulator 연동
      final host = kIsWeb
          ? 'localhost'
          : (Platform.isAndroid ? '10.0.2.2' : 'localhost');
      FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);

      getIt.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepositoryImpl(FirebaseAuth.instance),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => FirestorePostRepositoryImpl(FirebaseFirestore.instance),
      );
      break;

    case Flavor.dev:
    case null:
      // Dev: Mock 데이터 사용
      getIt.registerLazySingleton<AuthRepository>(
        (() => MockAuthRepositoryImpl()),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
      break;
  }
}

void _registerViewModels() {
  // 모든 ViewModel은 registerFactory를 사용하여 호출 시마다 새로 생성되도록 합니다.
  getIt.registerFactory(
    () => HomeViewModel(
      postRepository: getIt<PostRepository>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerFactory(
    () => AddPostViewModel(
      postRepository: getIt<PostRepository>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerFactory(
    () => LoginViewModel(authRepository: getIt<AuthRepository>()),
  );
}
