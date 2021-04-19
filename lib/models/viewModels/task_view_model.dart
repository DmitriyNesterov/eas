import 'dart:core';

import 'package:dio/dio.dart';
import 'package:eas/models/api/task_api.dart';
import 'package:eas/models/dto/task.dart';
import 'package:eas/models/params/task_params.dart';
import 'package:eas/models/viewModels/base_view_model.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends BaseViewModel<TaskApi> {
  Task? task;

  List<Task> _list = [];

  List<Task> get list => _list;

  TaskViewModel(context) : super(context, (Dio d) => TaskApi(d));

  int? _taskId;


  setTaskId(int value) {
    _taskId = value;
  }

  Future<Task?> getOne(int id) async {
    await get(id);
    task =
        list.length > 0 ? list.firstWhere((element) => element.id == id) : null;
    return task;
  }

  Future<void> get(int id) async {
    await initApi();
    try {
      var result = await apiRequest!.get(id);
      var l = result.rowData!.map((e) {
        return Task.fromJson(e);
      }).toList();
      task = l.first;
      _list = l;
      notifyListeners();
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      notifyListeners();
      return null;
    }
  }

  Future<void> add() async {
    await initApi();
    try {
      var result = await apiRequest!.add(TaskParams(id: _taskId!));
      if (result.result != null && result.result!.status == 200) get(0);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      notifyListeners();
      return null;
    }
  }
}
