class TaskParams {
  TaskParams({required this.id});
  int id;
  factory TaskParams.fromJson(Map<String, dynamic> json) {
    return TaskParams(
        id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
