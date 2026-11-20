import '../../data/repositories/task_repository.dart';
import '../../domain/models/task.dart';
import '../core/view_model.dart';

class TasksViewModel extends ViewModel {
  TasksViewModel({required TaskRepository taskRepository})
      : _taskRepository = taskRepository {
    _taskRepository.addListener(notifyListeners);
  }

  final TaskRepository _taskRepository;

  List<Task> get pendingTasks => _taskRepository.pendingTasks;
  List<Task> get doneTasks => _taskRepository.doneTasks;

  Future<void> load() => runLoad(() => _taskRepository.load());

  void toggleTask(String id) => _taskRepository.toggleTask(id);

  @override
  void dispose() {
    _taskRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
