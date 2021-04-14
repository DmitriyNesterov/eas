class AuthResult {
  String result;

  AuthResult({required this.result, required this.token});

  String token;

  factory AuthResult.fromJson(Map<String, dynamic> parsedJson){
    return AuthResult(
        result:parsedJson['result'],
        token:parsedJson['token']
    );
  }
}