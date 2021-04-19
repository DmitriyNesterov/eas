import 'package:dio/dio.dart';
import 'package:eas/models/dto/operation_result.dart';
import 'package:eas/models/params/auth_params.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: "http://edu-rest.nesterov.me/rest")
//@RestApi(baseUrl: "https://restd.ksvz.ru/rest")

abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/logout')
  Future<void> logout();

  @POST('/login')
  Future<OperationResult> login(@Body() AuthParams params);

  @GET('/data')
  Future<OperationResult> info();
}