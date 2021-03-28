import 'package:data/entities/user.dart';
import 'package:data/services/api-urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService {
  static Future<Response> loginUser({String login, String password}) {
    print({'email': login, 'password': password});
    return http.post(ApiUrls.getLoginUrl(),
        body: {'email': login, 'password': password});
  }

  static Future<Response> registerUser(dynamic user) {
    print(user);

    return http.post(ApiUrls.getRegisterUrl(), body: user);
  }
}
