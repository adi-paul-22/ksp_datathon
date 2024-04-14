import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/user_auth/presentation/resources/task.dart'; // Ensure this import points to your Task model correctly

class TaskService {
  final String _baseUrl = 'http://192.168.1.4:3000'; // Make sure this is the correct IP and port

  // Fetch Tasks - Assuming this works as expected
  Future<List<Task>> fetchTasks() async {
    final Uri fetchUrl = Uri.parse('$_baseUrl/fetch-data'); // Make sure endpoint is correct
    final response = await http.get(fetchUrl);

    if (response.statusCode == 200) {
      List<dynamic> tasksJson = json.decode(response.body);
      return tasksJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Create Task
  Future<void> createTask(Task task) async {
    final Uri createUrl = Uri.parse('$_baseUrl/create-task'); // Correct endpoint for creating a task
    final response = await http.post(
      createUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()), // Ensure Task model has a toJson method
    );

    if (response.statusCode != 201) { // Assuming 201 is the success status code returned by your server
      throw Exception('Failed to create task: ${response.body}');
    }
  }

  // Update Task
  Future<void> updateTask(Task task) async {
    if(task.id == null) {
      throw Exception("Task ID is null, cannot update task without an ID.");
    }

    final Uri updateUrl = Uri.parse('$_baseUrl/update-task/${task.id}'); // Correct endpoint for updating a task
    final response = await http.put(
      updateUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()), // Ensure Task model has a toJson method
    );

    if (response.statusCode != 200) { // Assuming 200 is the success status code for updates
      throw Exception('Failed to update task: ${response.body}');
    }
  }

  Future<void> deleteTask(String taskId) async {
    final Uri deleteUrl = Uri.parse('$_baseUrl/delete-task/$taskId'); // Correct endpoint for deleting a task
    final response = await http.delete(deleteUrl);

    if (response.statusCode != 200) { // Assuming 200 is the success status code for deletes
      throw Exception('Failed to delete task: ${response.body}');
    }
  }
}
