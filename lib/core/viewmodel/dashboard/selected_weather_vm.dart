import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/viewmodel/base_viewmodel.dart';

class SelectedWeatherVM extends BaseViewModel {
  final MyCity _city = locator<MyCity>();
  final List<City> _list = [];

  List<City> get cities => _list;

  City get selectedCity =>
      cities.firstWhere((c) => c.isSelected, orElse: () => cities.first);

  Future<void> changeSelectedCity(City city) async {
    for (City c in cities) {
      if (c.name != city.name) {
        c.isSelected = false;
      } else {
        c.isSelected = true;
      }
    }
    notifyListeners();
    await init();
  }

  Future<void> init() async {
    try {
      setBusy();
      if (_list.isEmpty) {
        _list.addAll(_city.thirtyCities);
      }
      await Future.wait([
        getSelectedCityWeather(),
        getForecast(),
      ]);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  Future<void> getSelectedCityWeather() async {
    selectedCity.weatherResponse = await service.getWeatherByCoordinates(
        coordinate: selectedCity.coordinate);
  }

  Future<void> getForecast() async {
    selectedCity.forecastResponse = await service.get5daysForecastByCoordinates(
      coordinate: selectedCity.coordinate,
    );
  }
}
