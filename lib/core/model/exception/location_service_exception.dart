import 'package:teleport_air_asia/core/service/localization/get_localization.dart';

class LocationServiceException implements Exception {
  const LocationServiceException();

  @override
  String toString() {
    return getLocalization.locationServiceDisabled;
  }
}