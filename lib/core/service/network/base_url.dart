import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/model/flavor_manager.dart';

String getBaseUrl() => FlavorManager.instance.settings.baseUrl;

Map<AppEnvironment, String> baseUrl = {
  AppEnvironment.dev: 'https://api.openweathermap.org',
  AppEnvironment.uat: 'https://api.openweathermap.org',
  AppEnvironment.prod: 'https://api.openweathermap.org',
};
