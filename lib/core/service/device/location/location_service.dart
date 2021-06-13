import 'package:location/location.dart';
import 'package:teleport_air_asia/core/model/exception/location_service_exception.dart';

abstract class LocationService {
  Future<LocationData?> getLocation();
}

class LocationServiceImpl implements LocationService {
  final Location _location = Location();

  @override
  Future<LocationData?> getLocation() async {

    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        throw const LocationServiceException();
      }
    }

    return await _location.getLocation();
  }
}
