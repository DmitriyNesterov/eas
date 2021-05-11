import 'package:intl/intl.dart';

class TaskButton {
  TaskButton({required this.id, required this.name, this.bg_color});
  int id;
  String name;
  String? bg_color;

  factory TaskButton.fromJson(Map<String, dynamic> responseData) {
    return TaskButton(
        id: responseData['id'],
        name: responseData['name'],
        bg_color: responseData['bg_color']);
  }
}

