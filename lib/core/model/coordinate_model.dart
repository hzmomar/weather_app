class Coordinate {
  late double longitude;
  late double latitude;

  final String _longitudeKey = 'logitude';
  final String _latitudeKey = 'latitude';

  Coordinate({
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() => {
    _longitudeKey : longitude,
    _latitudeKey : latitude,
  };

  Coordinate.fromPreferenceJson(Map<String, dynamic> json){
    longitude = json[_longitudeKey];
    latitude = json[_latitudeKey];
  }

  Coordinate.fromJson(Map<String, dynamic> json) {
    longitude = (json['lon']).toDouble();
    latitude = (json['lat']).toDouble();
  }

  @override
  String toString() {
    return 'Coordinate{longitude: $longitude, latitude: $latitude}';
  }
}
