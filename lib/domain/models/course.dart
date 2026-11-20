class Course {
  final String id;
  final String name;
  final String lecturer;
  final String room;

  /// 1 = Senin ... 5 = Jumat (sesuai DateTime.weekday).
  final int day;
  final String startTime;
  final String endTime;

  const Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      lecturer: json['lecturer'] as String,
      room: json['room'] as String,
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }
}
