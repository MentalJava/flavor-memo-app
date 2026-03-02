import 'package:flavor_memo_app/domain/repositories/auth_repository.dart';
import 'package:flavor_memo_app/domain/repositories/post_repository.dart';
import 'package:flavor_memo_app/presentation/component/flavor_banner.dart';
import 'package:flavor_memo_app/presentation/router.dart';
import 'package:flavor_memo_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.postRepository,
  });

  @override
  State<MyApp> createState() => _MyAppState();

  // Simple Service Locator pattern for this demo
  static MyApp of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<MyApp>()!;
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(widget.authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flavor Memo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _appRouter.router,
      builder: (context, child) =>
          FlavorBanner(child: child ?? const SizedBox()),
    );
  }
}
