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
    return Uri.http(environment.taskUrl, "/tasks/${taskId.isEmpty ? '' : taskId + '/'}");
  }

  static Uri getTaskNotesUrl() {
    return Uri.http(environment.taskUrl, "/tasks/notes/");
  }
}