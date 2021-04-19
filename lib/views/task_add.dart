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
          builder: (context, task, child) => Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _TaskIdInput(),
                  ElevatedButton(
                      child: Text("Сохранить"),
                      onPressed: () {
                        context.read<TaskViewModel>().add();
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
