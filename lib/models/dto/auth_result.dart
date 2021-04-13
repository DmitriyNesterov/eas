class AuthResult {
  String result;
  String token;

  AuthResult({this.result, this.token});
  factory AuthResult.fromJson(Map<String, dynamic> parsedJson){
    return AuthResult(
        result:parsedJson['result'],
        token:parsedJson['token']
    );
  }
}