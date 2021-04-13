import 'package:eas/models/dto/user.dart';
import 'package:flutter/material.dart';
import 'package:eas/views/login_form.dart';
import 'package:provider/provider.dart';

import 'models/repositories/user_repository.dart';

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
              return LoginForm(); //Splash();
          }
        }));
  }
}

class UserInfoPage extends StatelessWidget {
  //final User user;

  //const UserInfoPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('email'),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () => context.read<UserRepository>().logOut(),
            )
          ],
        ),
      ),
    );
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
