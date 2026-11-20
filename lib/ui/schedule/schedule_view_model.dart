import '../../data/repositories/schedule_repository.dart';
import '../../domain/models/course.dart';
import '../core/view_model.dart';

class ScheduleViewModel extends ViewModel {
  ScheduleViewModel({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository {
    final today = DateTime.now().weekday;
    _selectedDay = today <= 5 ? today : 1; // Sabtu/Minggu -> Senin
  }

  final ScheduleRepository _scheduleRepository;
  late int _selectedDay;

  int get selectedDay => _selectedDay;
  List<Course> get courses => _scheduleRepository.coursesForDay(_selectedDay);

  void selectDay(int day) {
    _selectedDay = day;
    notifyListeners();
  }

  Future<void> load() => runLoad(() => _scheduleRepository.load());
}
