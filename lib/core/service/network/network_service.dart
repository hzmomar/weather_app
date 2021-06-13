import 'package:teleport_air_asia/core/constant/endpoint.dart';
import 'package:teleport_air_asia/core/model/coordinate_model.dart';
import 'package:teleport_air_asia/core/model/forecast_response_model.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';
import 'package:teleport_air_asia/core/service/network/base_api.dart';

abstract class NetworkService {
  Future<WeatherResponse> getWeatherByCityId({required int cityId});

  Future<WeatherResponse> getWeatherByCoordinates(
      {required Coordinate coordinate});

  Future<ForecastResponse> get5daysForecastByCoordinates({
    required Coordinate coordinate,
  });
}

class NetworkServiceImpl implements NetworkService {
  final Api _api = Api();

  @override
  Future<WeatherResponse> getWeatherByCityId({required int cityId}) async {
    final Map<String, dynamic> _response = await _api.get(
      Endpoint.weather,
      queryParam: {
        'id': cityId,
      },
    );

    return WeatherResponse.fromJson(_response);
  }

  @override
  Future<WeatherResponse> getWeatherByCoordinates(
      {required Coordinate coordinate}) async {
    final Map<String, dynamic> _response =
        await _api.get(Endpoint.weather, queryParam: {
      'lat': coordinate.latitude,
      'lon': coordinate.longitude,
      'units': 'metric',
    });

    return WeatherResponse.fromJson(_response);
  }

  @override
  Future<ForecastResponse> get5daysForecastByCoordinates(
      {required Coordinate coordinate}) async {
    final Map<String, dynamic> _response = await _api.get(
      Endpoint.forecast,
      queryParam: {
        'lat' : coordinate.latitude,
        'lon' : coordinate.longitude,
        'units' : 'metric'
      },
    );
    
    return ForecastResponse.fromApiJson(_response['list']);
  }
}
