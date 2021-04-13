class AuthParams {
  AuthParams({this.username, this.password});
  String username;
  String password;
  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      username: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password
    };
  }
}
