import 'package:data/environment/environment.dart';

class ApiUrls {
  static Uri getLoginUrl() {
    return Uri.http(environment.authUrl, "/login/",);
  }

  static Uri getRegisterUrl() {
    return Uri.http(environment.authUrl, "/register/");
  }

  static Uri getRefreshTokenUrl() {
    return Uri.http(environment.authUrl, "/token/refresh/");
  }

  static Uri getTasksUrl({String taskId = ''}) {
    return Uri.http(environment.taskUrl, "/tasks/$taskId");
  }

  static Uri getTaskNotesUrl() {
    return Uri.http(environment.taskUrl, "/tasks/notes/");
  }

  static Uri getDeviceRegistrationUrl() {
    return Uri.http(environment.metricsUrl, "/metrics/devices/");
  }

  static Uri getDeviceByPublicId(String id) {
    return Uri.http(environment.metricsUrl, "/metrics/devices/recognize/${id}/");
  }

  static Uri getDeviceByName() {
    return Uri.http(environment.metricsUrl, "/metrics/devices/");
  }

  static Uri getDevices() {
    return Uri.http(environment.metricsUrl, "/metrics/devices/");
  }


}