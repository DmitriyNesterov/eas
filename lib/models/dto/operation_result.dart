class OperationResult {
  dynamic? data;
  List<dynamic>? rowData;
  DataLayerResult? result;

  OperationResult({this.data, this.rowData, this.result});

  factory OperationResult.fromJson(Map<String, dynamic> parsedJson) {
    return OperationResult(
        data: parsedJson['data'],
        rowData: parsedJson['rowData'],
        result: parsedJson['result']!=null?DataLayerResult.fromJson(parsedJson['result']):null
    );
  }
}

class DataLayerResult {
  DataLayerResult({required this.status, required this.code, required this.message});
  int status;
  int code;
  String message;

  factory DataLayerResult.fromJson(Map<String, dynamic> parsedJson){
    return DataLayerResult(
        status:parsedJson['status'],
        code:parsedJson['code'],
        message:parsedJson['message']
    );
  }
}