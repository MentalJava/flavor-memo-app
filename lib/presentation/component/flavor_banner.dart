import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  const FlavorBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProd) return child;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: FlavorConfig.name.toUpperCase(),
        location: BannerLocation.topStart,
        color: FlavorConfig.isDev ? Colors.blue : Colors.green,
        child: child,
      ),
    );
  }
}
