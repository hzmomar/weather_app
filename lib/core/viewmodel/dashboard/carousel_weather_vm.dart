import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/model/weather_response_model.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/viewmodel/base_viewmodel.dart';

class CarouselWeatherVM extends BaseViewModel {
  final MyCity _myCity = locator<MyCity>();
  final List<City> _list = [];
  List<City> selectedCities = [];

  List<City> get listOfCities => _list;

  // mark selected or not for master list
  void markSelectedCity(bool? b, int index) {
    if (_list[index].isSelected != b) {
      _list[index].isSelected = b ?? false;
      notifyListeners();
    }
  }

  Future<void> init() async {
    try {
      setBusy();
      // set master list
      if (_list.isEmpty) {
        _list.addAll(_myCity.thirtyCities);
      }
      // get cached selected cities
      selectedCities = await service.getSelectedCities();
      if (selectedCities.isEmpty) {
        selectedCities = _list.getRange(0, 3).toList();
      }
      // mark as selected
      for (City c in _list) {
        if (selectedCities.any((e) => e.name == c.name)) {
          c.isSelected = true;
        } else {
          c.isSelected = false;
        }
      }
      await _getWeatherForSelectedCities();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  Future<void> updateWeather() async {
    try {
      setBusy();
      // cached selectedWeather
      selectedCities = _list.where((e) => e.isSelected).toList();
      await service.savedSelectedCities(cities: selectedCities);
      await _getWeatherForSelectedCities();
      setIdle();
    }catch(e, s){
      setError(e, s);
    }
  }

  Future<void> _getWeatherForSelectedCities() async {
    final List<WeatherResponse> _result = await Future.wait<WeatherResponse>(
      selectedCities
          .map((e) => service.getWeatherByCoordinates(coordinate: e.coordinate))
          .toList(),
    );

    for (int i = 0; i < _result.length; i++) {
      selectedCities[i].weatherResponse = _result[i];
    }
  }
}
