import 'package:teleport_air_asia/core/service/localization/localization_service.dart';

/// helper class to add getter for localization class
class GetLocalization {
  String get error => localizationService.text('error');
  String get noInternetFullMsg => localizationService.text('noInternetFullMsg');
  String get splashScreen => localizationService.text('splashScreen');
  String get retry => localizationService.text('retry');
  String get cancel => localizationService.text('cancel');
  String get dashboard => localizationService.text('dashboard');
  String get feelsLike => localizationService.text('feelsLike');
  String get humidity => localizationService.text('humidity');
  String get minTemp => localizationService.text('minTemp');
  String get maxTemp => localizationService.text('maxTemp');
  String get locationServiceDisabled => localizationService.text('locationServiceDisabled');
  String get locationPermissionDenied => localizationService.text('locationPermissionDenied');
  String get forecast => localizationService.text('forecast');
  String get addCity => localizationService.text('addCity');
  String get selectedCites => localizationService.text('selectedCites');
  String get close => localizationService.text('close');
  String get update => localizationService.text('update');
}

GetLocalization getLocalization = GetLocalization();
