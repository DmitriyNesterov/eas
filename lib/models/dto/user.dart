class User {
  int id;

  User(
      {required this.id,
      required this.login,
      required this.name,
      required this.mail,
      required this.is_blocked,
      required this.is_admin,
      required this.is_deleted,
      required this.password,
      required this.p_sysuser_type_id});

  String login;
  String name;
  String mail;
  int is_blocked;
  int is_admin;
  int is_deleted;
  String password;
  int p_sysuser_type_id;

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        id: responseData['id'],
        login: responseData['login'],
        name: responseData['name'],
        mail: responseData['mail'],
        is_blocked: responseData['is_blocked'],
        is_admin: responseData['is_admin'],
        is_deleted: responseData['is_deleted'],
        password: responseData['password'],
        p_sysuser_type_id: responseData['p_sysuser_type_id']);
  }
}
