import 'package:teleport_air_asia/core/service/localization/get_localization.dart';

class LocationPermissionException implements Exception {
  const LocationPermissionException();

  @override
  String toString() {
    return getLocalization.locationPermissionDenied;
  }
}
