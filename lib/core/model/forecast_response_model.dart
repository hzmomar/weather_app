import 'package:collection/collection.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';

class ForecastResponse {
  List<WeatherResponse>? forecastWeathers;

  List<WeatherResponse> get fiveDayForecast {
    final Map<String, List<WeatherResponse>> _grouped =
        groupBy<WeatherResponse, String>(
      forecastWeathers ?? [],
      (weathers) => weathers.formattedTimeOfCalculation,
    );

    final List<WeatherResponse> _groupedForecast = [];
    _grouped.forEach(
      (key, value) {
        _groupedForecast.add(value.first);
      },
    );

    return _groupedForecast;
  }

  ForecastResponse.fromApiJson(List<dynamic>? json) {
    forecastWeathers = json
            ?.map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }
}
