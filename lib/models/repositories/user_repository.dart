import 'package:dio/dio.dart';
import 'package:eas/models/api/auth_api.dart';
import 'package:eas/models/dto/auth_result.dart';
import 'package:eas/models/dto/operation_result.dart';
import 'package:eas/models/params/auth_params.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository extends ChangeNotifier {
  Status _loggedInStatus = Status.Uninitialized;

  BuildContext _context;

  Status get loggedInStatus => _loggedInStatus;

  AuthApi _apiRequest;
  Dio dio;

  UserRepository(BuildContext context){
    _context = context;
    dio = Dio();
    _apiRequest = AuthApi(dio);
  }

  Future<AuthResult> login(
      {String username, String password}) async {
    try {
      username = 'din';
      password = 'AdminEdu';
      _loggedInStatus = Status.Authenticating;
      notifyListeners();
      var result = await _apiRequest.login(AuthParams(username: username, password: password));
      var r = AuthResult.fromJson(result.data);
      if (r != null && r.result == 'OK') {

        dio.options.headers['Authorization'] = 'bearer {r.token}';
        _loggedInStatus = Status.Authenticated;
        notifyListeners();
        return r;
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
       ScaffoldMessenger.of(_context).showSnackBar(snackBar);
      _loggedInStatus = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<OperationResult> info() async {
    try {
      var result = await _apiRequest.info();
      return result;
    } catch (e) {
      _loggedInStatus = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  void logOut() async {
    _apiRequest.logout();
    notifyListeners();
    _loggedInStatus = Status.Unauthenticated;
  }

}
