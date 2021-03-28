class User {
  int id;
  String name;
  String last_name;
  String first_name;
  String email;
  String password;

  User(this.last_name, this.first_name, this.email, this.password, this.name, this.id);

  User.login({String last_name, String first_name, String email, int id}) :
  this(last_name, first_name, email, null, null, id);

  User.register(
      {String last_name, String first_name, String email, String password})
      : this(last_name, first_name, email, password, null, null);

  User.registerFromJson(Map<String, dynamic> json)
      : this.register(
            password: json['password'],
            email: json['email'],
            first_name: json['first_name'],
            last_name: json['last_name']);

  User.loginFromJson(Map<String, dynamic> json)
      : this.login(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name']);
}
