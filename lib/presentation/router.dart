import 'package:flavor_memo_app/presentation/home/home_root.dart';
import 'package:go_router/go_router.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/post_repository.dart';
import 'login/login_screen.dart';
import 'home/home_view_model.dart';
import 'add_post/add_post_screen.dart';

class AppRouter {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  AppRouter(this.authRepository, this.postRepository);

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
          final viewModel = HomeViewModel(
            postRepository: postRepository,
            authRepository: authRepository,
          );
          viewModel.fetchPosts();
          return HomeRoot(viewModel: viewModel);
        },
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => AddPostScreen(
              authRepository: authRepository,
              postRepository: postRepository,
            ),
          ),
        ],
      ),
    ],
  );
}
