import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../resources/task.dart'; // Make sure this import is correct
import 'edit_task_page.dart'; // Make sure this import is correct
import 'create_task_page.dart'; // Make sure this import is correct
import '../../../../services/task_service.dart'; // Make sure this import is correct
import 'package:ksp_datathon/global/common/toast.dart'; // Make sure this import is correct

class UpdateTaskPage extends StatefulWidget {
  const UpdateTaskPage({Key? key}) : super(key: key);

  @override
  UpdateTaskPageState createState() => UpdateTaskPageState();
}

class UpdateTaskPageState extends State<UpdateTaskPage> {
  final TaskService taskService = TaskService();
  List<Task> tasks = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      List<Task> tasksData = await taskService.fetchTasks();
      setState(() {
        tasks = tasksData;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateAndEditTask(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTaskPage(task: task)),
    );

    if (result == 'update') {
      _fetchTasks();
    }
  }

  void _navigateAndCreateTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTaskPage()),
    );

    if (result == 'create') {
      _fetchTasks();
    }
  }

  void _deleteTask(String taskId) async {
  

  try {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/delete-task/$taskId'),
    );

    if (response.statusCode == 200) {
      showToast(message: "Task successfully deleted");
      _fetchTasks(); // Refresh the list after deletion
    } else {
      // If the server's response is not OK, log or display the error
      final responseData = json.decode(response.body);
      showToast(message: "Failed to delete the task: ${responseData['error']}");
    }
  } catch (e) {
    showToast(message: "An error occurred: $e");
  }
}


  void _confirmDeleteTask(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text('Are you sure you want to delete "${task.name}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteTask(task.id.toString()); // Call the delete method
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _searchTask(String query) async {
    if (query.isEmpty) {
      _fetchTasks();
    } else {
      final response = await http.get(
        Uri.parse('http://localhost:3000/search-task?name=$query'),
      );

      if (response.statusCode == 200) {
        final List<Task> filteredTasks = (json.decode(response.body) as List)
            .map((data) => Task.fromJson(data))
            .toList();
        setState(() {
          tasks = filteredTasks;
        });
      } else {
        showToast(message: "Error occurred while searching for tasks");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchTask(_searchController.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.task),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateAndEditTask(task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _confirmDeleteTask(task),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndCreateTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
