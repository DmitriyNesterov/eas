import 'package:flutter/material.dart';
import 'package:eas/views/login_form.dart';
import 'package:provider/provider.dart';

import 'models/repositories/user_repository.dart';
import 'views/user_info_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserRepository(context),
        child: Consumer<UserRepository>(builder: (context, user, child) {
          switch (user.loggedInStatus) {
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginForm();
            case Status.Authenticated:
              return UserInfoPage();
            default:
              return Splash();
          }
        }));
  }
}



class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
