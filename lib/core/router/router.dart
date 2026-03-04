import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/presentation/home/home_root.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/post_repository.dart';
import '../../presentation/login/login_screen.dart';
import '../../presentation/home/home_view_model.dart';
import '../../presentation/add_post/add_post_screen.dart';

class AppRouter {
  final AuthRepository authRepository = getIt<AuthRepository>();

  late final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: authRepository,
    redirect: (context, state) {
      final loggedIn = authRepository.currentUser != null;
      final loggingIn = state.matchedLocation == '/login';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            LoginScreen(authRepository: authRepository),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          final viewModel = getIt<HomeViewModel>();
          viewModel.fetchPosts();
          return HomeRoot(viewModel: viewModel);
        },
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => AddPostScreen(
              authRepository: authRepository,
              postRepository: getIt<PostRepository>(),
            ),
          ),
        ],
      ),
    ],
  );
}
