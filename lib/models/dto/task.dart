import 'package:eas/models/dto/task_button.dart';
import 'package:intl/intl.dart';

class Task {

  Task({required this.id, this.plan_dt, this.executor, this.create_dt, this.taskStatus, this.reason});
  int id;
  DateTime? plan_dt;
  int? executor;
  int? reason;
  DateTime? create_dt;
  TaskButton? taskStatus;

  factory Task.fromJson(Map<String, dynamic> responseData) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    return Task(
        id: responseData['id'],
        plan_dt: format.parse(responseData['plan_dt']),
        executor: responseData['executor'],
        reason: responseData['reason'],
        create_dt: format.parse(responseData['create_dt']),
        taskStatus: TaskButton.fromJson(responseData['taskStatus'])
    );
  }
}
