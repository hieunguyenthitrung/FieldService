import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future setConfig(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AppConfig(flavor: flavor);
}

class AppConfig {
  final Flavor flavor;
  bool isTestEnv;

  static AppConfig? _instance;

  factory AppConfig({
    required Flavor flavor,
    bool isTestEnv = false,
  }) {
    _instance ??= AppConfig._(flavor, isTestEnv);
    return _instance!;
  }

  AppConfig._(
    this.flavor,
    this.isTestEnv,
  );

  static AppConfig get instance => _instance!;
}

enum Flavor {
  staging,
  production,
}

extension FlavorExtension on Flavor {
  FlavorValues get flavorValues {
    switch (this) {
      case Flavor.production:
        return const FlavorValues(
          name: '',
          baseUrl: 'url',
          termsPath: '',
          faqPath: '',
          appStoreUrl: '',
          playStoreUrl: '',
        );
      case Flavor.staging:
      default:
        return const FlavorValues(
          name: '',
          baseUrl: 'url',
          termsPath: '',
          faqPath: '',
          appStoreUrl: '',
          playStoreUrl: '',
        );
    }
  }
}

class FlavorValues {
  final String name;
  final String baseUrl;
  final String termsPath;
  final String faqPath;
  final String appStoreUrl;
  final String playStoreUrl;

  const FlavorValues({
    required this.name,
    required this.baseUrl,
    required this.termsPath,
    required this.faqPath,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });
}
