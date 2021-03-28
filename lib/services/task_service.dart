import 'dart:convert';

import 'package:data/entities/task.dart';
import 'package:data/services/api-urls.dart';
import 'package:data/utils/authenticated_http_client.dart';
import 'package:http/http.dart';

class TaskService {
  AuthenticatedHttpClient _httpClient = new AuthenticatedHttpClient();

  Future<List<Task>> getTasks() {
    return _httpClient.get(ApiUrls.getTasksUrl()).then((value) {
      Iterable response = jsonDecode(value.body);

      return List<Task>.from(response.map((e) => Task.fromJson(e)));
    });
  }

  Future addTask(Task task) {
    print(task.creator_id);

    return _httpClient.post(ApiUrls.getTasksUrl(), body: jsonEncode(task.taskAddToJson())).then((value) {
      print(jsonDecode(value.body));
    });
  }

  Future updateTask(Task task) {
    print(task.id);

    return _httpClient.patch(ApiUrls.getTasksUrl(taskId: task.id.toString()), body: jsonEncode(task.taskUpdateToJson())).then((value) {
      print(jsonDecode(value.body));
    });
  }

  Future<Response> deleteTask(Task task) {
    return _httpClient.delete(ApiUrls.getTasksUrl(taskId: task.id.toString()));
  }
}
