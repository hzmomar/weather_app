import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';

class FlavorSettings {
  FlavorSettings({
    required this.baseUrl,
    this.apiKey = const String.fromEnvironment(ConstantString.defineApiKey),
  });

  final String apiKey;
  final String baseUrl;
}

class FlavorManager {
  final AppEnvironment env;
  final FlavorSettings settings;

  static FlavorManager? _instance;

  factory FlavorManager(
      {required AppEnvironment env, required FlavorSettings settings}) {
    return _instance ??= FlavorManager._internal(env: env, settings: settings);
  }

  FlavorManager._internal({required this.env,required this.settings});

  static FlavorManager get instance => _instance!;

  bool get isProd => _instance!.env == AppEnvironment.prod;

  bool get isDev => _instance!.env == AppEnvironment.dev;

  bool get isUat => _instance!.env == AppEnvironment.uat;
}