import 'package:dio/dio.dart';
import 'package:eas/models/api/auth_api.dart';
import 'package:eas/models/dto/auth_result.dart';
import 'package:eas/models/params/auth_params.dart';
import 'package:eas/models/repositories/base_repository.dart';
import 'package:flutter/material.dart';

import '../api/auth_api.dart';
import '../dto/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository extends BaseRepository<AuthApi> {

  Status _loggedInStatus = Status.Uninitialized;
  Status get loggedInStatus => _loggedInStatus;

  User? _user;

  User? getUser() {
    return _user;
  }

  String _username = "";

  setUsername(String value) {
    _username = value;
  }

  String _password = "";

  setPassword(String value) {
    _password = value;
  }




  UserRepository(context) : super(context, (Dio d) => AuthApi(d))
  {
    getApiClient();
    _loggedInStatus = Status.Unauthenticated;
    notifyListeners();
  }

  void login() async {
    try {
      _username = 'din';
      _password = 'AdminEdu';
      _loggedInStatus = Status.Authenticating;
      notifyListeners();
      var result = await apiRequest!
          .login(AuthParams(username: _username, password: _password));
      var r = AuthResult.fromJson(result.data);
      if (r.result == 'OK') {
        await storage.write(key: USER_TOKEN, value: r.token);
        getApiClient();
        _loggedInStatus = Status.Authenticated;
        notifyListeners();
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      _loggedInStatus = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  void info() async {
    try {
      var result = await apiRequest!.info();
      _user = User.fromJson(result.data);
      notifyListeners();
    } catch (e) {
      _loggedInStatus = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  void logOut() async {
    apiRequest!.logout();
    storage.delete(key: USER_TOKEN);
    _loggedInStatus = Status.Unauthenticated;
    notifyListeners();
  }
}
