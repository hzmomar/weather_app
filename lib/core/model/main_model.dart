class Main {
  double? temp;
  double? feels_like;
  double? min_temp;
  double? max_temp;
  int? pressure;
  int? humidity;

  Main.fromJson(Map<String, dynamic> json){
    temp = (json['temp']).toDouble();
    feels_like = (json['feels_like']).toDouble();
    min_temp = (json['temp_min']).toDouble();
    max_temp = (json['temp_max']).toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  @override
  String toString() {
    return 'Main{temp: $temp, feels_like: $feels_like, min_temp: $min_temp, max_temp: $max_temp, pressure: $pressure, humidity: $humidity}';
  }
}