import 'package:nusa_kampus/data/services/campus_service.dart';

/// Service palsu tanpa delay untuk testing.
class FakeCampusService extends CampusService {
  FakeCampusService({this.failAnnouncements = false});

  final bool failAnnouncements;

  @override
  Future<List<Map<String, dynamic>>> fetchCourses() async => [
        {
          'id': 'c1',
          'name': 'Pemrograman Mobile',
          'lecturer': 'Dr. Andi',
          'room': 'Lab 3',
          'day': DateTime.now().weekday,
          'startTime': '08:00',
          'endTime': '10:00',
        },
      ];

  @override
  Future<List<Map<String, dynamic>>> fetchTasks() async => [
        {
          'id': 't1',
          'title': 'Tugas Satu',
          'courseName': 'Basis Data',
          'dueDate': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
          'isDone': false,
        },
        {
          'id': 't2',
          'title': 'Tugas Dua',
          'courseName': 'Statistika',
          'dueDate': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          'isDone': false,
        },
      ];

  @override
  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    if (failAnnouncements) throw Exception('Server tidak dapat dihubungi');
    return [
      {
        'id': 'a1',
        'title': 'Pengumuman Lama',
        'body': 'Isi pengumuman lama',
        'author': 'Akademik',
        'date': DateTime(2025, 1, 1).toIso8601String(),
      },
      {
        'id': 'a2',
        'title': 'Pengumuman Baru',
        'body': 'Isi pengumuman baru',
        'author': 'Kemahasiswaan',
        'date': DateTime(2025, 6, 1).toIso8601String(),
      },
    ];
  }
}
