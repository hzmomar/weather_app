import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';
import 'package:teleport_air_asia/core/service/localization/localization_service.dart';
import 'package:teleport_air_asia/core/service/navigation/nav_router.dart';
import 'package:teleport_air_asia/core/service/navigation/navigation_service.dart';
import 'package:teleport_air_asia/ui/shared/theme_data.dart';
import 'package:teleport_air_asia/ui/view/splash/splash_view.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstantString.appName,
      theme: defaultThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: NavRouter.generateRoute,
      navigatorKey: navigationService.navigationKey,
      supportedLocales: localizationService.supportedLocales(),
      initialRoute: NavRouter.initialRoute,
      home: const SplashView(),
    );
  }
}
