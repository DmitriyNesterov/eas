class TaskParams {
  int id;
  double? latitude;
  double? longitude;

  TaskParams({required this.id, this.latitude, this.longitude});

  factory TaskParams.fromJson(Map<String, dynamic> json) {
    return TaskParams(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
