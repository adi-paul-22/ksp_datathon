import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduledTasksPage extends StatefulWidget {
  const ScheduledTasksPage({super.key});

  @override
  _ScheduledTasksPageState createState() => _ScheduledTasksPageState();
}

class _ScheduledTasksPageState extends State<ScheduledTasksPage> {
  late Map<DateTime, List<String>> _scheduledTasks;
  late List<String> _selectedTasks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _scheduledTasks = {
      // Example tasks, replace with your own logic and dat
      DateTime.utc(2024, 3, 19): ['Beat: 4'],
    };

    _selectedDay = _focusedDay;
    _selectedTasks = _scheduledTasks[_selectedDay!] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: const Text('Scheduled Tasks'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          TableCalendar<String>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedTasks = _scheduledTasks[_selectedDay!] ?? [];
              });
            },
            eventLoader: (day) => _scheduledTasks[day] ?? [],
            calendarStyle: CalendarStyle(
              // Customize the current date style
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              // Customize the selected date style
              selectedDecoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.rectangle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          const Divider(),
          Expanded(
  child: _selectedTasks.isEmpty
      ? const Center(child: Text('No tasks for today'))
      : ListView.builder(
          itemCount: _selectedTasks.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedTasks[index]), // Displays the task title
                    const Text('beat: 4'), // Static content for demonstration
                  ],
                ),
              ),
            );
          },
        ),
),

        ],
      ),
    );
  }
}