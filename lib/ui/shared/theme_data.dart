import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';

final ThemeData defaultThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
    brightness: Brightness.dark,
    actionsIconTheme: IconThemeData(color: ThemeColor.shadeBlack),
    centerTitle: true,
    color: ThemeColor.brandLightBlue,
    elevation: 0,
    iconTheme: IconThemeData(color: ThemeColor.shadeBlack),
    backwardsCompatibility: false,
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: ThemeColor.brandLightBlue),
  ),
  scaffoldBackgroundColor: ThemeColor.shadeWhite,
);
