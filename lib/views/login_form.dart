import 'package:eas/models/viewModels/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/ksvz.png'),
                  const Padding(padding: EdgeInsets.all(12)),
                  _UsernameInput(),
                   const Padding(padding: EdgeInsets.all(12)),
                   _PasswordInput(),
                   const Padding(padding: EdgeInsets.all(12)),
                   _LoginButton(),
                ],
              ),
            )));
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) =>
          context.read<UserViewModel>().setUsername(username),
      decoration: InputDecoration(
        labelText: 'username',
        //errorText: state.username.invalid ? 'invalid username' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<UserViewModel>().setPassword(password),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        //errorText: state.password.invalid ? 'invalid password' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.read<UserViewModel>().loggedInStatus ==
            Status.Authenticating
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            child: const Text('Login'),
            onPressed: () => {
                  context
                      .read<UserViewModel>()
                      .login()
                });
  }
}
