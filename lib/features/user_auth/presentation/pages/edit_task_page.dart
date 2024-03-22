import 'package:flutter/material.dart';
import '../resources/task.dart';
import '../../../../services/task_service.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({super.key, required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _taskController;
  late TextEditingController _statusController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _taskController = TextEditingController(text: widget.task.task);
    _statusController = TextEditingController(text: widget.task.status);
    _selectedDate = widget.task.taskdate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _taskController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      Task updatedTask = Task(
        id: widget.task.id,
        name: _nameController.text,
        task: _taskController.text,
        taskdate: _selectedDate,
        status: _statusController.text,
      );
      TaskService().updateTask(updatedTask).then((_) {
        Navigator.pop(context, 'update');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating task: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task ${widget.task.id}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a status';
                }
                return null;
              },
            ),
            ListTile(
              title: Text('Task Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
