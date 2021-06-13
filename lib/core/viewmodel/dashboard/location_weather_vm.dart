import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:teleport_air_asia/core/model/coordinate_model.dart';
import 'package:teleport_air_asia/core/model/exception/location_permission_exception.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';
import 'package:teleport_air_asia/core/viewmodel/base_viewmodel.dart';

class LocationWeatherVM extends BaseViewModel {
  late PermissionStatus locationPermissionStatus;
  WeatherResponse? locationWeather;

  bool get locationGranted =>
      locationPermissionStatus == PermissionStatus.granted ||
      locationPermissionStatus == PermissionStatus.limited ||
      locationPermissionStatus == PermissionStatus.restricted;

  Future<void> init() async {
    // check permission
    try {
      setBusy();
      locationPermissionStatus = await Permission.location.status;
      if (locationGranted) {
        await getWeather();
      }
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  Future<void> checkPermission() async {
    try {
      setBusy();
      locationPermissionStatus = await Permission.location.status;
      if (locationPermissionStatus == PermissionStatus.denied) {
        locationPermissionStatus = await Permission.location.request();
        if(!locationGranted) {
          throw const LocationPermissionException();
        }else{
          await getWeather();
        }
      } else if (locationPermissionStatus == PermissionStatus.permanentlyDenied) {
        throw const LocationPermissionException();
      }
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  Future<void> getWeather() async {
    final location.LocationData? _locationData = await service.getLocation();
    if (_locationData != null) {
      locationWeather = await service.getWeatherByCoordinates(
        coordinate: Coordinate(
          longitude: _locationData.longitude!,
          latitude: _locationData.latitude!,
        ),
      );
    }
  }
}
