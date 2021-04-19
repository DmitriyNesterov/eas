import 'package:intl/intl.dart';

class Task {

  Task({required this.id, this.plan_dt, this.executor, this.create_dt, this.taskStatus});
  int id;
  DateTime? plan_dt;
  int? executor;
  DateTime? create_dt;
  TaskStatus? taskStatus;

  factory Task.fromJson(Map<String, dynamic> responseData) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    return Task(
        id: responseData['id'],
        plan_dt: format.parse(responseData['plan_dt']),
        executor: responseData['executor'],
        create_dt: format.parse(responseData['create_dt']),
        taskStatus: TaskStatus.fromJson(responseData['taskStatus'])
    );
  }
}

class TaskStatus {
  TaskStatus({required this.id, required this.name, required this.task_actual_id, required this.is_finished, this.bg_color});
  int id;
  String name;
  int task_actual_id;
  bool is_finished;
  String? bg_color;

  factory TaskStatus.fromJson(Map<String, dynamic> responseData) {
    return TaskStatus(
        id: responseData['id'],
        name: responseData['name'],
        task_actual_id: responseData['task_actual_id'],
        is_finished: responseData['is_finished'],
        bg_color: responseData['bg_color']);
  }
}

