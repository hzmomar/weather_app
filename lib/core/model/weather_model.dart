import 'package:teleport_air_asia/core/constant/string_constant.dart';

class Weather {
  late int id;
  String? main;
  String? description;
  String? icon;

  String get iconPngPath => '${ConstantString.weatherIconBaseUrl}$icon.png';

  Weather.fromJson(Map<String, dynamic> json){
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  @override
  String toString() {
    return 'Weather{id: $id, main: $main, description: $description, icon: $icon}';
  }
}