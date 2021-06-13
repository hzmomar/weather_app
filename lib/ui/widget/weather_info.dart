import 'package:flutter/material.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';
import 'package:teleport_air_asia/core/model/main_model.dart';
import 'package:teleport_air_asia/core/model/weather_model.dart';
import 'package:teleport_air_asia/core/model/wind_model.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';
import 'package:teleport_air_asia/ui/widget/weather_icon_widget.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    required Weather? weather,
    required Main? main,
    required Wind? wind,
    Key? key,
  })  : _weather = weather,
        _main = main,
        _wind = wind,
        super(key: key);

  final Weather? _weather;
  final Main? _main;
  final Wind? _wind;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// temperature
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// icon
              WeatherIcon(pngPath: _weather?.iconPngPath),

              /// temperature
              Text(
                '${_main?.temp?.toInt()} ${ConstantString.celciusIndicator}',
                style: RobotoStyle.h3.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: ThemeColor.informationB700,
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// wind speed
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// compass icon
                    const Icon(
                      Icons.cloud_queue_outlined,
                      size: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        '${_wind?.speed}m/s N',
                        style: RobotoStyle.caption,
                      ),
                    )
                  ],
                ),

                /// humidity
                Text(
                  '${getLocalization.humidity} : ${_main?.humidity}%',
                  style: RobotoStyle.caption,
                ),

                /// Min Temp
                Text(
                  '${getLocalization.minTemp} : ${_main?.min_temp}%',
                  style: RobotoStyle.caption,
                ),

                /// Max Temp
                Text(
                  '${getLocalization.maxTemp} : ${_main?.max_temp}%',
                  style: RobotoStyle.caption,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
