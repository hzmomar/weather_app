import 'package:location/location.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/model/coordinate_model.dart';
import 'package:teleport_air_asia/core/model/forecast_response_model.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';
import 'package:teleport_air_asia/core/service/device/location/location_service.dart';
import 'package:teleport_air_asia/core/service/network/network_service.dart';
import 'package:teleport_air_asia/core/service/sharedpreference/sharedpreference_service.dart';

import 'locator/locator.dart';

abstract class Service {
  Future<WeatherResponse> getWeatherByCityId({required int cityId});

  Future<WeatherResponse> getWeatherByCoordinates(
      {required Coordinate coordinate});

  Future<LocationData?> getLocation();

  Future<ForecastResponse> get5daysForecastByCoordinates({
    required Coordinate coordinate,
  });

  Future<void> savedSelectedCities({required List<City> cities});

  Future<List<City>> getSelectedCities();
}

class ServiceImpl implements Service {
  final NetworkService _networkService = locator<NetworkService>();
  final LocationService _locationService = locator<LocationService>();
  final PreferencesService _preferencesService = locator<PreferencesService>();

  @override
  Future<WeatherResponse> getWeatherByCityId({required int cityId}) async =>
      await _networkService.getWeatherByCityId(cityId: cityId);

  @override
  Future<WeatherResponse> getWeatherByCoordinates(
          {required Coordinate coordinate}) async =>
      await _networkService.getWeatherByCoordinates(
        coordinate: coordinate,
      );

  @override
  Future<LocationData?> getLocation() async =>
      await _locationService.getLocation();

  @override
  Future<ForecastResponse> get5daysForecastByCoordinates(
          {required Coordinate coordinate}) async =>
      await _networkService.get5daysForecastByCoordinates(
        coordinate: coordinate,
      );

  @override
  Future<List<City>> getSelectedCities() async =>
      await _preferencesService.getSelectedCities();

  @override
  Future<void> savedSelectedCities({required List<City> cities}) async =>
      await _preferencesService.savedSelectedCities(cities: cities);
}
