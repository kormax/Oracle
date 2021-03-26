import 'package:data/environment/environment.dart';

class ApiUrls {
  static Uri getLoginUrl() {
    return Uri.http(environment.authUrl, "/login/",);
  }

  static Uri getRegisterUrl() {
    return Uri.http(environment.authUrl, "/register/");
  }
}