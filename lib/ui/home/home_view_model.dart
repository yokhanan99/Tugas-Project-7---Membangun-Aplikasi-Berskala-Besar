import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import '../core/view_model.dart';

/// Menggabungkan data dari ScheduleRepository dan TaskRepository.
class HomeViewModel extends ViewModel {
  HomeViewModel({
    required ScheduleRepository scheduleRepository,
    required TaskRepository taskRepository,
  })  : _scheduleRepository = scheduleRepository,
        _taskRepository = taskRepository {
    // Beranda ikut berubah saat tugas dicentang di tab Tugas.
    _taskRepository.addListener(notifyListeners);
  }

  final ScheduleRepository _scheduleRepository;
  final TaskRepository _taskRepository;

  List<Course> get todayCourses =>
      _scheduleRepository.coursesForDay(DateTime.now().weekday);

  List<Task> get pendingTasks => _taskRepository.pendingTasks;

  Future<void> load() => runLoad(() async {
        await Future.wait([
          _scheduleRepository.load(),
          _taskRepository.load(),
        ]);
      });

  @override
  void dispose() {
    _taskRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
