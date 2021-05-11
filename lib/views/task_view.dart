import 'package:eas/models/dto/task.dart';
import 'package:eas/models/dto/task_button.dart';
import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/status_button.dart';

class TaskView extends StatelessWidget {
  int id;

  TaskView({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Заявка " + id.toString()),
        ),
        body: Consumer<TaskViewModel>(
          builder: (context, task, child) => Center(
            child: new WillPopScope(
                onWillPop: () async => await _onBackPressed(context),
                child: _TaskInfo(id)),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _onBackPressed(BuildContext context) {
  var taskViewModel = context.read<TaskViewModel>();
  return taskViewModel
      .get(0, true)
      .then((value) => Navigator.pop(context, true));
}

class _TaskInfo extends StatelessWidget {
  int id;

  List<TaskButton>? statusList;

  _TaskInfo(this.id);

  @override
  Widget build(BuildContext context) {
    var taskVm = context.read<TaskViewModel>();
    taskVm.setTaskId(id);
    taskVm.nextStatus(id);
    statusList = taskVm.statusList;

    return statusList != null
        ? Center(
            child: ListView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: statusList!.length,
                itemBuilder: (_, index) => StatusButton(
                      taskStatus: statusList![index],
                      taskVm: taskVm,
                    )))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
