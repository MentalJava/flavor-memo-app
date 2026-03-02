import 'package:go_router/go_router.dart';
import '../domain/repositories/auth_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_post_screen.dart';

class AppRouter {
  final AuthRepository authRepository;

  AppRouter(this.authRepository);

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
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddPostScreen(),
          ),
        ],
      ),
    ],
  );
}
