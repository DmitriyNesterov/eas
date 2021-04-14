import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/repositories/user_repository.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<UserRepository>().info();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: context.read<UserRepository>().getUser() == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(context.read<UserRepository>().getUser()!.login),
                  Text(context.read<UserRepository>().getUser()!.name),
                  ElevatedButton(
                    child: Text("SIGN OUT"),
                    onPressed: () => context.read<UserRepository>().logOut(),
                  )
                ],
              ),
      ),
    );
  }
}
