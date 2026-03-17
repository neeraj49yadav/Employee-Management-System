// lib/core/config/flavor_config.dart

enum Flavor {
  development,
  staging,
  production,
}

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;

  static late FlavorConfig _instance;

  FlavorConfig._internal({
    required this.flavor,
    required this.baseUrl,
  });

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
  }) {
    _instance = FlavorConfig._internal(
      flavor: flavor,
      baseUrl: baseUrl,
    );
    return _instance;
  }

  static FlavorConfig get instance => _instance;

  bool get isDevelopment => flavor == Flavor.development;
  bool get isStaging => flavor == Flavor.staging;
  bool get isProduction => flavor == Flavor.production;
}