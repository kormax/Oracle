class User {
  String name;
  String last_name;
  String first_name;
  String email;
  String password;

  User(this.last_name, this.first_name, this.email, this.password, this.name);

  User.Register(
      {String last_name, String first_name, String email, String password})
      : this(last_name, first_name, email, password, null);
}
