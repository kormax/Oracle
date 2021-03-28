import 'dart:convert';
import 'dart:io';

import 'package:data/entities/user_token.dart';
import 'package:data/services/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthenticatedHttpClient extends http.BaseClient {
  static UserToken token;

  int _retryCount = 0;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.putIfAbsent('content-type', () => 'application/json');

    if (token != null) {
      request.headers.putIfAbsent('Authorization', () => 'Bearer ${token.access}');
    }

    return request.send().then((http.StreamedResponse response) async {
      if (response.statusCode == HttpStatus.unauthorized && _retryCount == 0) {
        _retryCount++;

        Map<String, dynamic> newToken =  await AuthService.refreshToken(token.refresh).then((value) => jsonDecode(value.body));

        token.access = newToken['access'];

        send(request);
      }

      return response;
    });
  }

  static void reset() {
    token = null;
  }
}