import 'package:dio/dio.dart';
import 'package:eas/models/api/auth_apis.dart';
import 'package:eas/models/dto/auth_result.dart';
import 'package:eas/models/dto/operation_result.dart';
import 'package:eas/models/params/auth_params.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: "http://restd.ksvz.ru/rest")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST(AuthApis.logout)
  Future<void> logout();

  @POST(AuthApis.login)
  Future<OperationResult> login(@Body() AuthParams params);

  @GET(AuthApis.info)
  Future<OperationResult> info();
}