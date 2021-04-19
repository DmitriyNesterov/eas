import 'package:eas/models/dto/task.dart';
import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskView extends StatelessWidget {
  int id;

  TaskView({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Заявка"),
        ),
        body: Consumer<TaskViewModel>(
          builder: (context, task, child) => Center(
            child: _TaskInfo(id),
          ),
        ),
      ),
    );
  }
}

class _TaskInfo extends StatelessWidget {
  int id;

  _TaskInfo(this.id);

  @override
  Widget build(BuildContext context) {
    final taskVm = context.read<TaskViewModel>();
    taskVm.getOne(id);
    var task = taskVm.task;
    return task != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(task.id.toString()),
              const Padding(padding: EdgeInsets.all(12)),
              ElevatedButton(
                child: Text("Назад"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
