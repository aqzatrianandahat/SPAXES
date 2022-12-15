class User {
  final String username, password, email;
  final int id;

  User(
      {required this.username,
        required this.password,
        required this.email,
        required this.id});

  factory User.fromJSON(Map parsedJson) {
    return User(
        id: parsedJson['id'],
        username: parsedJson['username'],
        password: parsedJson['password'],
        email: parsedJson['email']);
  }
}