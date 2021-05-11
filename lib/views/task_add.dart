import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TaskAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Добавить задачу"),
        ),
        body: Consumer<TaskViewModel>(
          builder: (context, taskViewModel, child) => Center(
            child: new WillPopScope(
              onWillPop: () async => await _onBackPressed(context),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _TaskIdInput(),
                    ElevatedButton(
                        child: Text("Приступил к задаче"),
                        onPressed: () {
                          taskViewModel.setStatus(2).then((value) {
                            Navigator.pop(context, true);
                          });
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _onBackPressed(BuildContext context) {
  var taskViewModel = context.read<TaskViewModel>();
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Сохранить?"),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Нет")),
          ElevatedButton(
              onPressed: () {
                taskViewModel.add().then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: Text("Да"))
        ],
      ));
}

class _TaskIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('taskAdd_taskIdInput_textField'),
      onChanged: (id) => context.read<TaskViewModel>().setTaskId(int.parse(id)),
      decoration: InputDecoration(
        labelText: 'Номер задачи',
        //errorText: state.username.invalid ? 'invalid username' : null,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}
