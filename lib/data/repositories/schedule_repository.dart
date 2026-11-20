import '../../domain/models/course.dart';
import '../services/campus_service.dart';

class ScheduleRepository {
  ScheduleRepository({required CampusService service}) : _service = service;

  final CampusService _service;

  List<Course> _courses = const [];
  bool _loaded = false;
  Future<void>? _inFlight;

  List<Course> get courses => _courses;

  /// Mengambil data hanya sekali (di-cache), kecuali [refresh] = true.
  Future<void> load({bool refresh = false}) {
    if (_loaded && !refresh) return Future.value();
    return _inFlight ??= _fetch().whenComplete(() => _inFlight = null);
  }

  Future<void> _fetch() async {
    final json = await _service.fetchCourses();
    _courses = json.map(Course.fromJson).toList();
    _loaded = true;
  }

  /// [day]: 1 = Senin ... 5 = Jumat (sesuai DateTime.weekday).
  List<Course> coursesForDay(int day) {
    final list = _courses.where((c) => c.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }
}
