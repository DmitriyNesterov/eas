import 'package:eas/models/viewModels/task_view_model.dart';
import 'package:eas/models/viewModels/user_view_model.dart';
import 'package:eas/views/login_form.dart';
import 'package:eas/views/splash_page.dart';
import 'package:eas/views/task_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>(
            create: (context) => UserViewModel(context),
          ),
          ChangeNotifierProvider<TaskViewModel>(
            create: (context) => TaskViewModel(context),
          ),
        ],
        child: Consumer<UserViewModel>(builder: (context, user, child) {
          switch (user.loggedInStatus) {
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginForm();
            case Status.Authenticated:
              return Consumer<TaskViewModel>(
                builder: (context, model, child) => Container(
                  child: TaskList(),
                ),
              );
          //return UserInfoPage();
            default:
              return SplashPage();
          }
        }));
  }
}