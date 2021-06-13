import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/model/main_model.dart';
import 'package:teleport_air_asia/core/model/weather_model.dart';
import 'package:teleport_air_asia/core/model/wind_model.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/selected_weather_vm.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';
import 'package:teleport_air_asia/ui/widget/loading_icon_widget.dart';
import 'package:teleport_air_asia/ui/widget/retry_dialog_widget.dart';
import 'package:teleport_air_asia/ui/widget/weather_icon_widget.dart';
import 'package:teleport_air_asia/ui/widget/weather_info.dart';

import '../base_view.dart';

class SelectedWeather extends StatelessWidget {
  const SelectedWeather({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BaseView<SelectedWeatherVM>(
      onModelReady: (vm) => init(vm, _),
      builder: (context, vm) {
        return Card(
          elevation: 4,
          child: Selector<SelectedWeatherVM, City>(
            selector: (_, vm) => vm.selectedCity,
            builder: (_, selectedCity, __) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// city selection
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      width: MediaQuery.of(_).size.width,
                      child: DropdownButton<City>(
                        isDense: true,
                        isExpanded: true,
                        underline: const SizedBox(),
                        elevation: 0,
                        value: selectedCity,
                        onChanged: (City? city) {
                          vm.changeSelectedCity(city ?? vm.cities.first);
                        },
                        items: vm.cities
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    '${c.name}',
                                    style: RobotoStyle.h4,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),

                    /// weather info
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: weatherInfo(context, selectedCity),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Selector<SelectedWeatherVM, bool> weatherInfo(
      BuildContext context, City selectedCity) {
    return Selector<SelectedWeatherVM, bool>(
      selector: (_, vm) => vm.isBusy,
      builder: (_, isBusy, __) {
        if (isBusy) {
          return const LoadingIcon(
            height: 50,
          );
        } else {
          final Weather? _weather = selectedCity.weatherResponse?.weather.first;
          final Main? _main = selectedCity.weatherResponse?.main;
          final Wind? _wind = selectedCity.weatherResponse?.wind;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// info
              Text(
                '${getLocalization.feelsLike}'
                ' ${(_main?.feels_like)?.toInt() ?? 0} ${ConstantString.celciusIndicator}.'
                ' ${_weather?.main} . '
                '${_weather?.description}',
                style: RobotoStyle.caption.copyWith(
                  fontWeight: FontWeight.normal,
                  color: ThemeColor.shade80,
                ),
              ),

              /// weather info desc
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WeatherInfo(
                  weather: _weather,
                  main: _main,
                  wind: _wind,
                ),
              ),

              /// forecast info
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  getLocalization.forecast,
                  style: RobotoStyle.button,
                ),
              ),

              /// forecast table
              forecastTable(selectedCity)
            ],
          );
        }
      },
    );
  }

  Column forecastTable(City selectedCity) {
    return Column(
      children: selectedCity.forecastResponse?.fiveDayForecast.map<Widget>(
            (weather) {
              return Row(
                children: [
                  /// forecast date
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      weather.formattedTimeOfCalculation,
                      style: RobotoStyle.caption,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /// weather icon
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: WeatherIcon(
                            pngPath: weather.weather.first.iconPngPath,
                            size: const Size(30, 30),
                          ),
                        ),

                        /// min/max temp
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '${(weather.main.min_temp)?.toInt()} / ${(weather.main.max_temp)?.toInt()} ${ConstantString.celciusIndicator}',
                            style: RobotoStyle.caption,
                          ),
                        ),

                        /// weather description
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '${weather.weather.first.description}',
                            style: RobotoStyle.caption,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ).toList() ??
          [],
    );
  }

  Future<void> init(SelectedWeatherVM vm, BuildContext context) async {
    await vm.init();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message ?? '',
        context: context,
        callback: () => init(vm, context),
      );
    }
  }

  Future<void> changeSelectedCity(
      SelectedWeatherVM vm, BuildContext context) async {
    await vm.init();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message ?? '',
        context: context,
        callback: () => init(vm, context),
      );
    }
  }
}
