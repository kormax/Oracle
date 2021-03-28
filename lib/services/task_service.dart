import 'dart:convert';

import 'package:data/entities/task.dart';
import 'package:data/services/api-urls.dart';
import 'package:data/utils/authenticated_http_client.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class TaskService {
  AuthenticatedHttpClient _httpClient = new AuthenticatedHttpClient();

  Future<List<Task>> getTasks() {
    return _httpClient.get(ApiUrls.getTasksUrl()).then((value) {
      Iterable response = jsonDecode(value.body);

      return List<Task>.from(response.map((e) => Task.fromJson(e)));
    });
  }

  Future addTask(Task task) {
    print(task.taskAddToJson());

    return http.post(ApiUrls.getTasksUrl(), body: task.taskAddToJson()).then((value) {
      print(value.body);
    });
  }

  Future<Response> deleteTask(Task task) {
    return _httpClient.delete(ApiUrls.getTasksUrl(taskId: task.id.toString()));
  }
}
