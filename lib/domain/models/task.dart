class Task {
  final String id;
  final String title;
  final String courseName;
  final DateTime dueDate;
  final bool isDone;

  const Task({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      courseName: json['courseName'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      isDone: (json['isDone'] as bool?) ?? false,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? courseName,
    DateTime? dueDate,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      courseName: courseName ?? this.courseName,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
