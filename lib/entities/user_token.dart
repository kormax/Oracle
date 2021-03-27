class UserToken {
  String refresh;
  String access;

  UserToken(this.refresh, this.access);

  UserToken.fromJson(Map<String, dynamic> json) : this(json['refresh'].toString(), json['access'].toString());
}