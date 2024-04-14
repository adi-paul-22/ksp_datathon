import 'package:flutter/material.dart';
import '../../../../services/task_service.dart';  // Adjust the path as necessary
import 'edit_task_page.dart';  // Adjust the path as necessary
import 'create_task_page.dart';  // Adjust the path as necessary
import '../resources/task.dart';  // Adjust the path as necessary

class TaskScreenWeb extends StatefulWidget {
  const TaskScreenWeb({Key? key}) : super(key: key);

  @override
  _TaskScreenWebState createState() => _TaskScreenWebState();
}

class _TaskScreenWebState extends State<TaskScreenWeb> {
  final TaskService taskService = TaskService();
  List<Task> tasks = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks'),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text("No tasks available."))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.task),
                  subtitle: Text(task.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _navigateAndEditTask(task),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndCreateTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
