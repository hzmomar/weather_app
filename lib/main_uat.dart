import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/model/flavor_manager.dart';
import 'package:teleport_air_asia/core/service/localization/localization_service.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';

import 'core/service/network/base_url.dart';
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlavorManager(
      env: AppEnvironment.uat,
      settings: FlavorSettings(
          baseUrl: baseUrl[AppEnvironment.uat]!
      )
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await localizationService.init();

  runApp(MyApp());
}