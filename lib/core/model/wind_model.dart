class Wind {
  double? speed;
  double? degree;

  Wind.fromJson(Map<String, dynamic> json){
    speed = (json['speed']).toDouble();
    degree = (json['deg']).toDouble();
  }

  @override
  String toString() {
    return 'Wind{speed: $speed, degree: $degree}';
  }
}