import 'package:dio/dio.dart';
import 'package:eas/models/dto/operation_result.dart';
import 'package:eas/models/params/task_params.dart';
import 'package:eas/models/params/task_status_params.dart';
import 'package:retrofit/retrofit.dart';
part 'task_api.g.dart';

@RestApi(baseUrl: "http://edu-rest.nesterov.me/task")
// @RestApi(baseUrl: "https://restd.ksvz.ru/task")

abstract class TaskApi {
  factory TaskApi(Dio dio, {String baseUrl}) = _TaskApi;

  @POST('/add')
  Future<OperationResult> add(@Body() TaskParams params);

  @POST('/set-status')
  Future<OperationResult> setStatus(@Body() TaskStatusParams params);

  @GET('/tasks')
  Future<OperationResult> get(@Query("id") int id);

  @GET('/next-step')
  Future<OperationResult> nextStep(@Query("id") int id);
}