class Task {
  final int? id;
  final String name;
  final String task;
  final DateTime taskdate;
  final String status;

  Task({required this.id, required this.name, required this.task, required this.taskdate, required this.status});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      task: json['task'],
      taskdate: DateTime.parse(json['taskdate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'task': task,
      'taskdate': taskdate.toIso8601String(),
      'status': status,
    };
  }
}
