import 'package:get_it/get_it.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/service/device/location/location_service.dart';
import 'package:teleport_air_asia/core/service/network/network_service.dart';
import 'package:teleport_air_asia/core/service/service.dart';
import 'package:teleport_air_asia/core/service/sharedpreference/sharedpreference_service.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/carousel_weather_vm.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/location_weather_vm.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/selected_weather_vm.dart';
import 'package:teleport_air_asia/core/viewmodel/startup_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<MyCity>(MyCity());
  locator.registerLazySingleton<PreferencesService>(
      () => PreferencesServiceImpl());
  locator.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
  locator.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  locator.registerLazySingleton<Service>(() => ServiceImpl());

  locator.registerFactory<StartupVM>(() => StartupVM());
  locator.registerFactory<SelectedWeatherVM>(() => SelectedWeatherVM());
  locator.registerFactory<LocationWeatherVM>(() => LocationWeatherVM());
  locator.registerFactory<CarouselWeatherVM>(() => CarouselWeatherVM());
}
