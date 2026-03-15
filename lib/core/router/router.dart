import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/core/router/go_router_refresh_stream.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_root.dart';
import 'package:flavor_memo_app/presentation/add_post/add_post_view_model.dart';
import 'package:flavor_memo_app/presentation/home/home_root.dart';
import 'package:flavor_memo_app/presentation/login/login_root.dart';
import 'package:flavor_memo_app/presentation/login/login_view_model.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repository/auth_repository.dart';
import '../../presentation/home/home_view_model.dart';

class AppRouter {
  final AuthRepository authRepository = getIt<AuthRepository>();

  late final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authRepository.userStatus),
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
            LoginRoot(viewModel: getIt<LoginViewModel>()),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          final viewModel = getIt<HomeViewModel>();
          return HomeRoot(viewModel: viewModel);
        },
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) =>
                AddPostRoot(viewModel: getIt<AddPostViewModel>()),
          ),
        ],
      ),
    ],
  );
}
