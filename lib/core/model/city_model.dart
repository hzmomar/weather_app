import 'package:teleport_air_asia/core/model/coordinate_model.dart';
import 'package:teleport_air_asia/core/model/forecast_response_model.dart';
import 'package:teleport_air_asia/core/model/selectable_mixin.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';

class City with Selectable {
  late String name;
  late String? state;
  late String countryCode;
  late Coordinate coordinate;
  WeatherResponse? weatherResponse;
  ForecastResponse? forecastResponse;

  final String _nameKey = 'name';
  final String _stateKey = 'state';
  final String _countryCodeKey = 'countryCode';
  final String _coordinateKey = 'coordinate';

  City.fromJson(Map<String, dynamic> json) {
    name = json['city'];
    state = json['admin_name'];
    countryCode = json['iso2'];
    coordinate  = Coordinate.fromJson({
      'lon' : double.parse(json['lng']),
      'lat' : double.parse(json['lat']),
    });
  }

  City.fromPreferenceJson(Map<String, dynamic> json) {
    name = json[_nameKey];
    state = json[_stateKey];
    countryCode = json[_countryCodeKey];
    coordinate = Coordinate.fromPreferenceJson(json[_coordinateKey]);
  }

  Map<String, dynamic> toJson() => {
    _nameKey : name,
    _stateKey : state,
    _countryCodeKey : countryCode,
    _coordinateKey : coordinate.toJson(),
  };
}

class MyCity {
  List<City> cities = [];

  List<City> get thirtyCities => cities.getRange(0, 30).toList();

  void init(List<dynamic> json) {
    cities = json.map((e) {
      return City.fromJson(e as Map<String, dynamic>);
    }).toList();
  }
}
