import 'package:eas/models/dto/task.dart';
import 'package:eas/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {Key? key,
      required this.task,
      required this.dateFormat,
      required this.dateTimeFormat})
      : super(key: key);

  final Task task;
  final DateFormat dateTimeFormat;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        color: task.taskStatus!.bg_color == null
            ? Colors.transparent
            : HexColor(task.taskStatus!.bg_color!),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          title: Text(task.id.toString(), style: TextStyle(fontSize: 50)),
          subtitle: Wrap(
            spacing: 5,
            children: [
              Text(
                dateFormat.format(task.plan_dt!),
              ),
              Text(
                dateTimeFormat.format(task.create_dt!),
              )
            ],
          ),
          leading: Icon(
            Icons.star,
            size: 40,
            color: Colors.black,
          ),
          onTap: () => Navigator.pushNamed(context, "/task/${task.id}").then((value) => context.read<TaskViewModel>().get(0,true)),
        ));
  }
}
