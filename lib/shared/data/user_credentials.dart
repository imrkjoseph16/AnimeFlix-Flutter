class UserCredentials {
  String username;
  String password;

  UserCredentials({required this.username, required this.password});

  factory UserCredentials.fromMap(Map<String, dynamic> map) => UserCredentials(
      username: map['username'],
      password: map['password'],
    );

  Map<String, dynamic> toMap() => {
      'username': username,
      'password': password,
    };
}
