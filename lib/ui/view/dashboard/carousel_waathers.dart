import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/core/service/navigation/navigation_service.dart';
import 'package:teleport_air_asia/core/viewmodel/dashboard/carousel_weather_vm.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';
import 'package:teleport_air_asia/ui/view/base_view.dart';
import 'package:teleport_air_asia/ui/widget/loading_icon_widget.dart';
import 'package:teleport_air_asia/ui/widget/retry_dialog_widget.dart';
import 'package:teleport_air_asia/ui/widget/weather_info.dart';

class CarouselWeather extends StatelessWidget {
  const CarouselWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BaseView<CarouselWeatherVM>(
      onModelReady: (vm) => init(vm, _),
      builder: (context, vm) {
        return Selector<CarouselWeatherVM, bool>(
          selector: (_, vm) => vm.isBusy,
          builder: (_, isBusy, __) {
            if (isBusy) {
              return const LoadingIcon(height: 500);
            } else {
              return weatherCarousel(context, vm);
            }
          },
        );
      },
    );
  }

  Selector<CarouselWeatherVM, List<City>> weatherCarousel(
      BuildContext context, CarouselWeatherVM vm) {
    return Selector<CarouselWeatherVM, List<City>>(
      selector: (_, vm) => vm.selectedCities,
      builder: (_, selectedCities, __) {
        return CarouselSlider.builder(
          itemCount: selectedCities.length + 1,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          itemBuilder: (_, index, __) {
            if (index < selectedCities.length) {
              final City _city = selectedCities[index];
              return weatherCard(_city);
            } else {
              return addCityCard(context, vm);
            }
          },
        );
      },
    );
  }

  Card weatherCard(City _city) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// state
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '${_city.name}',
                  style: RobotoStyle.h4,
                ),
              ),

              /// weather info
              WeatherInfo(
                weather: _city.weatherResponse?.weather.first,
                main: _city.weatherResponse?.main,
                wind: _city.weatherResponse?.wind,
              )
            ],
          ),
        ),
      ),
    );
  }

  Card addCityCard(BuildContext context, CarouselWeatherVM vm) {
    return Card(
      elevation: 2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// add button
            IconButton(
              icon: const Icon(
                Icons.add,
                color: ThemeColor.shade80,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return selectedCitiesDialog(vm, context);
                  },
                );
              },
            ),

            /// add weather text
            Text(
              getLocalization.addCity,
              style: RobotoStyle.button.copyWith(
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedCitiesDialog(CarouselWeatherVM vm, BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// title
              Text(
                getLocalization.selectedCites,
                style: RobotoStyle.bodyText1,
              ),

              /// city checkbox
              Expanded(
                child: ChangeNotifierProvider<CarouselWeatherVM>.value(
                  value: vm,
                  child: Selector<CarouselWeatherVM, List<City>>(
                    selector: (_, vm) => vm.listOfCities,
                    shouldRebuild: (_, __) => true,
                    builder: (_, listOfCities, __) {
                      return ListView.builder(
                        itemCount: listOfCities.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CheckboxListTile(
                            value: listOfCities[index].isSelected,
                            onChanged: (bool? v) {
                              vm.markSelectedCity(v, index);
                            },
                            title: Text(
                              listOfCities[index].name,
                              style: RobotoStyle.caption,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              /// update button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ThemeColor.brandLightBlue),
                  ),
                  onPressed: () {
                    navigationService.pop();
                    updateWeather(vm, context);
                  },
                  child: Text(
                    getLocalization.update,
                    style: RobotoStyle.button
                        .copyWith(color: ThemeColor.shadeWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> init(CarouselWeatherVM vm, BuildContext context) async {
    await vm.init();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message ?? '',
        context: context,
        callback: () => init(vm, context),
      );
    }
  }

  Future<void> updateWeather(CarouselWeatherVM vm, BuildContext context) async {
    await vm.updateWeather();
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message,
        context: context,
        callback: () => updateWeather(vm, context),
      );
    }
  }
}
