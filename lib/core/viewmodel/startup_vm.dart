import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:teleport_air_asia/core/constant/asset_constant.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/service/navigation/nav_router.dart';
import 'package:teleport_air_asia/core/service/navigation/navigation_service.dart';
import 'package:teleport_air_asia/core/viewmodel/base_viewmodel.dart';

class StartupVM extends BaseViewModel {

  Future<void> handleStartUp() async {

    // init my cities
    try {
      setBusy();
      final MyCity _myCity = locator<MyCity>();
      final String jsonContent = await rootBundle.loadString(ConstantAsset.malaysiaCitiesJsonPath);
      _myCity.init(json.decode(jsonContent));
      setIdle();

      await navigationService.pushAndRemoveUntil(NavRouter.dashboardRoute);
    }catch(e, s){
      setError(e, s);
    }
  }
}