import 'package:flavor_memo_app/presentation/add_post/add_post_view_model.dart';
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
    case Flavor.dev:
    case Flavor.staging:
    case Flavor.prod:
    case null:
      // 현재는 모든 환경에서 Mock을 사용하지만, 실제 환경 분기가 필요한 경우 여기서 처리합니다.
      getIt.registerLazySingleton<AuthRepository>(
        (() => MockAuthRepositoryImpl()),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
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
}
