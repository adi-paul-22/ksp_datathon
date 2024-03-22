import 'package:flutter/material.dart';
import '../resources/task.dart';
import '../../../../services/task_service.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _idController.dispose();
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

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      Task newTask = Task(
        id: int.tryParse(_idController.text),
        name: _nameController.text,
        task: _taskController.text,
        taskdate: _selectedDate,
        status: _statusController.text,
      );
      TaskService().createTask(newTask).then((_) {
        Navigator.pop(context, 'create');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating task: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null) {
                  return 'Please enter a valid ID';
                }
                return null;
              },
            ),
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
              onPressed: _createTask,
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
