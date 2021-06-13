import 'package:intl/intl.dart';
import 'package:teleport_air_asia/core/model/coordinate_model.dart';
import 'package:teleport_air_asia/core/model/main_model.dart';
import 'package:teleport_air_asia/core/model/weather_model.dart';
import 'package:teleport_air_asia/core/model/wind_model.dart';

class WeatherResponse {
  late Coordinate? coordinate;
  late List<Weather> weather;
  String? base;
  late Main main;
  late int visibility;
  Wind? wind;
  int? cloudiness;
  late DateTime timeOfCalculation;
  late int? timezone;
  late int? cityId;
  late String? cityName;

  String get formattedTimeOfCalculation {
    final DateFormat _dateFormat = DateFormat('EEE, MMM dd');
    return _dateFormat.format(timeOfCalculation);
  }

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    coordinate =
        json.containsKey('coord') ? Coordinate.fromJson(json['coord']) : null;
    weather = (json['weather'] as List)
        .map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList();
    base = json['base'];
    main = Main.fromJson(json['main'] as Map<String, dynamic>);
    visibility = json['visibility'];
    wind = Wind.fromJson(json['wind'] as Map<String, dynamic>);
    cloudiness = json['clouds']['all'];
    timeOfCalculation =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true);
    timezone = json.containsKey('timezone') ? json['timezone'] : null;
    cityId = json.containsKey('id') ? json['id'] : null;
    cityName = json.containsKey('name') ? json['name'] : null;
  }

  @override
  String toString() {
    return 'WeatherResponse{coordinate: $coordinate, weather: $weather, base: $base, main: $main, visibility: $visibility, wind: $wind, cloudiness: $cloudiness, timeOfCalculation: $timeOfCalculation, timezone: $timezone, cityId: $cityId, cityName: $cityName}';
  }
}
