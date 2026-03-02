enum Flavor { dev, staging, prod }

abstract class FlavorConfig {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? 'dev';

  static bool get isDev => appFlavor == Flavor.dev;
  static bool get isStaging => appFlavor == Flavor.staging;
  static bool get isProd => appFlavor == Flavor.prod;
}
