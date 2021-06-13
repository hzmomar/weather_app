import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/location_weather_vm.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/view/base_view.dart';
import 'package:teleport_air_asia/ui/widget/loading_icon_widget.dart';
import 'package:teleport_air_asia/ui/widget/retry_dialog_widget.dart';
import 'package:teleport_air_asia/ui/widget/weather_info.dart';

class LocationWeather extends StatelessWidget {
  const LocationWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BaseView<LocationWeatherVM>(
      onModelReady: (vm) => init(vm, _),
      builder: (context, vm) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Selector<LocationWeatherVM, bool>(
              selector: (_, vm) => vm.isBusy,
              builder: (_, isBusy, __) {
                if (isBusy) {
                  return const Center(
                    child: LoadingIcon(),
                  );
                } else {
                  return Selector<LocationWeatherVM, bool>(
                    selector: (_, vm) => vm.locationGranted,
                    shouldRebuild: (_, __) => true,
                    builder: (_, locationGranted, __) {
                      if (locationGranted) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// my location
                            Row(
                              children: [
                                /// location icon
                                const Icon(Icons.location_on_outlined),

                                /// city name
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    vm.locationWeather?.cityName ?? '',
                                    style: RobotoStyle.h4,
                                  ),
                                ),
                              ],
                            ),

                            /// weather info
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: WeatherInfo(
                                main: vm.locationWeather?.main,
                                weather: vm.locationWeather?.weather.first,
                                wind: vm.locationWeather?.wind,
                              ),
                            )
                          ],
                        );
                      } else {
                        /// locate me button
                        return Container(
                          height: 100,
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.location_on_outlined),
                              onPressed: () {
                                getWeather(vm, context);
                              },
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> init(LocationWeatherVM vm, BuildContext context) async {
    await vm.init();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message ?? '',
        context: context,
        callback: () => init(vm, context),
      );
    }
  }

  Future<void> getWeather(LocationWeatherVM vm, BuildContext context) async {
    await vm.checkPermission();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message ?? '',
        context: context,
        callback: () => getWeather(vm, context),
      );
    }
  }
}
