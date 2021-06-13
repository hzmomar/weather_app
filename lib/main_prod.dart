import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/constant/enum.dart';
import 'core/model/flavor_manager.dart';
import 'core/service/localization/localization_service.dart';
import 'core/service/locator/locator.dart';
import 'core/service/network/base_url.dart';
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlavorManager(
      env: AppEnvironment.prod,
      settings: FlavorSettings(
          baseUrl: baseUrl[AppEnvironment.prod]!
      )
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await localizationService.init();

  runApp(MyApp());
}