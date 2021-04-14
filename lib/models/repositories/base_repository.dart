import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef ItemCreator<T> = T Function(Dio dio);

abstract class BaseRepository<T> extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final USER_TOKEN = "token";

  BuildContext ctx;

  ItemCreator<T> creator;

  T? apiRequest;

  BaseRepository(this.ctx, this.creator);

  final storage = new FlutterSecureStorage();

  void getApiClient() async {
    var dio = Dio();
    var token = await storage.read(key: USER_TOKEN);
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token != null) {
          options.headers["Authorization"] = "Bearer " + token;
        }
        return handler.next(options);
      },
    ));
    apiRequest = creator(dio);
  }
}
