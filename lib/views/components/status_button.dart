import 'package:eas/models/dto/task_button.dart';
import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:eas/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

class StatusButton extends StatelessWidget {


  final TaskButton taskStatus;
  final TaskViewModel taskVm;

  const StatusButton({Key? key, required this.taskStatus, required this.taskVm})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: ElevatedButton(
            child: Text(taskStatus.name),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              primary: taskStatus.bg_color == null
                  ? Colors.transparent
                  : HexColor(taskStatus.bg_color!), // background
              onPrimary: Colors.black, // foreground
            ),
            onPressed: () {
              taskVm.setStatus(taskStatus.id).then(
                      (value) => taskVm.nextStatus(value, true)
              );
            },
        ));
  }
}
