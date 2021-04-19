import 'package:eas/models/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<UserViewModel>().info();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: context.read<UserViewModel>().getUser() == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(context.read<UserViewModel>().getUser()!.login),
                  Text(context.read<UserViewModel>().getUser()!.name),
                  ElevatedButton(
                    child: Text("SIGN OUT"),
                    onPressed: () => context.read<UserViewModel>().logOut(),
                  )
                ],
              ),
      ),
    );
  }
}
