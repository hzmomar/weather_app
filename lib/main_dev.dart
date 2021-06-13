import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/model/flavor_manager.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/service/network/base_url.dart';
import 'package:teleport_air_asia/main.dart';

import 'core/service/localization/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlavorManager(
    env: AppEnvironment.dev,
    settings: FlavorSettings(
      baseUrl: baseUrl[AppEnvironment.dev]!,
    )
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await localizationService.init();

  runApp(MyApp());
}