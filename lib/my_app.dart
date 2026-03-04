import 'package:flavor_memo_app/presentation/component/flavor_banner.dart';
import 'package:flavor_memo_app/core/router/router.dart';
import 'package:flavor_memo_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'Flavor Memo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter.router,
      builder: (context, child) =>
          FlavorBanner(child: child ?? const SizedBox()),
    );
  }
}
