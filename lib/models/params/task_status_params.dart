class TaskStatusParams {
  int id;
  int status;
  double? latitude;
  double? longitude;

  TaskStatusParams({required this.id, required this.status, this.latitude, this.longitude});

  factory TaskStatusParams.fromJson(Map<String, dynamic> json) {
    return TaskStatusParams(
      id: json['id'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'status': status.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
