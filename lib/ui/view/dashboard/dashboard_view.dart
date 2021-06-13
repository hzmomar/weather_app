import 'package:flutter/material.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/view/dashboard/carousel_waathers.dart';
import 'package:teleport_air_asia/ui/view/dashboard/location_weather.dart';
import 'package:teleport_air_asia/ui/view/dashboard/selected_weather.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getLocalization.dashboard,
          style: RobotoStyle.button,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [

            /// 30 country weathers
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SelectedWeather(),
            ),

            /// location weather
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: LocationWeather(),
            ),

            /// carousel weather
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: CarouselWeather(),
            ),
          ],
        ),
      ),
    );
  }
}