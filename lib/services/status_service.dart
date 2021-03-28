import 'dart:convert';

import 'package:data/entities/status.dart';
import 'package:data/services/api-urls.dart';
import 'package:data/utils/authenticated_http_client.dart';
import 'package:http/http.dart';

class StatusService {
  AuthenticatedHttpClient _httpClient = new AuthenticatedHttpClient();

  Future<Status> getStatus() {
    return _httpClient.get(ApiUrls.getStatusUrl()).then((value) {
      var response = jsonDecode(value.body);

      return Status.fromJson(response);
    });
  }

  Future<Response> getWeeklyReport() {
    return _httpClient.get(ApiUrls.getWeeklyReportUrl());
  }
}