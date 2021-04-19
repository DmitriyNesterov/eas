
import 'package:eas/views/main_page.dart';
import 'package:eas/views/task_view.dart';
import 'package:flutter/material.dart';

import 'views/task_add.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MainPage(),
      '/add': (BuildContext context) => TaskAdd(),
    },
      onGenerateRoute: (routeSettings) {
      var path = routeSettings.name!.split('/');
      if (path[1] == 'task') {
        return MaterialPageRoute(builder: (context)=>TaskView(id:int.parse(path[2])));
      }
    },
  ));
}
