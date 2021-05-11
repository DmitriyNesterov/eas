import 'package:eas/models/dto/task.dart';
import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:eas/models/viewModels/user_view_model.dart';
import 'package:eas/views/task_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/task_card.dart';

class TaskList extends StatelessWidget {
  final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  final DateFormat dateTimeFormat = DateFormat("dd.MM.yyyy HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final taskVm = context.read<TaskViewModel>();
    taskVm.get(0);
    return Scaffold(
      appBar: AppBar(
          title: Text("Список задач"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Выход',
              onPressed: () {
                context.read<UserViewModel>().logOut();
              },
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () => taskVm.get(0, true),
        child: ListView.builder(
          //physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          itemCount: taskVm.list.length,
          itemBuilder: (_, index) => TaskCard(
            task: taskVm.list[index],
            dateFormat: dateFormat,
            dateTimeFormat: dateTimeFormat,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) => taskVm.get(0,true));
        },
      ),
    );
  }
}
