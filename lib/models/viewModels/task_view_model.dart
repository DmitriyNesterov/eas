import 'dart:core';

import 'package:dio/dio.dart';
import 'package:eas/models/api/task_api.dart';
import 'package:eas/models/dto/task.dart';
import 'package:eas/models/dto/task_button.dart';
import 'package:eas/models/params/task_params.dart';
import 'package:eas/models/params/task_status_params.dart';
import 'package:eas/models/viewModels/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class TaskViewModel extends BaseViewModel<TaskApi> {
  final Location location = Location();
  Task? task;

  bool _notify = true;
  bool _notifyStatus = true;

  List<TaskButton> _statusList = <TaskButton>[];

  List<TaskButton> get statusList => _statusList;

  List<Task> _list = [];

  List<Task> get list => _list;

  TaskViewModel(context) : super(context, (Dio d) => TaskApi(d));

  int? _taskId;

  int getTaskId() => _taskId ?? 0;

  setTaskId(int value) {
    _taskId = value;
  }

  Future<Task?> getOne([int id = 0]) async {
    if (id == 0) id = _taskId ?? 0;
    await get(id);
    task =
        list.length > 0 ? list.firstWhere((element) => element.id == id) : null;
    return task;
  }

  Future<void> get(int id, [bool notify = false]) async {
    if (_notify || notify) {
      await initApi();
      try {
        var result = await apiRequest!.get(id);
        var l = result.rowData!.map((e) {
          return Task.fromJson(e);
        }).toList();
        task = (l.length>0) ? l.first : null;
        _list = l;
        notifyListeners();
        _notify = false;
      } catch (e) {
        showError(e.toString());
        notifyListeners();
        return null;
      }
    }
    return null;
  }

  Future<void> nextStatus(int id, [bool notify = false]) async {
    if (_notifyStatus || notify) {
      await initApi();
      try {
        var result = await apiRequest!.nextStep(id);
        var l = result.rowData!.map((e) {
          return TaskButton.fromJson(e);
        }).toList();
        _statusList = l;
        notifyListeners();
        _notifyStatus = false;
      } catch (e) {
        showError(e.toString());
        //notifyListeners();
      }
    }
  }

  Future<int> setStatus(int status) async {
    await initApi();
    LocationData pos = await location.getLocation();
    try {
      var result = await apiRequest!
          .setStatus(TaskStatusParams(id: _taskId!, status: status, latitude: pos.latitude, longitude: pos.longitude));
      if (result.result != null && result.result!.status != 200)
        showError(result.result!.message);
    } catch (e) {
      showError(e.toString());
      //notifyListeners();
    }
    return _taskId ?? 0;
  }

  Future<int> add() async {
    await initApi();
    LocationData pos = await location.getLocation();
    try {
      var result = await apiRequest!.add(TaskParams(id: _taskId!, latitude: pos.latitude, longitude: pos.longitude));
      if (result.result != null && result.result!.status != 200)
        showError(result.result!.message);
    } catch (e) {
      showError(e.toString());
      //notifyListeners();
    }
    return  _taskId ?? 0;
  }
}
