import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';
import '../services/campus_service.dart';

/// ChangeNotifier supaya Beranda, tab Tugas, dan badge ikut berubah
/// ketika sebuah tugas dicentang.
class TaskRepository extends ChangeNotifier {
  TaskRepository({required CampusService service}) : _service = service;

  final CampusService _service;

  List<Task> _tasks = const [];
  bool _loaded = false;
  Future<void>? _inFlight;

  List<Task> get tasks => _tasks;
  List<Task> get pendingTasks => _tasks.where((t) => !t.isDone).toList();
  List<Task> get doneTasks => _tasks.where((t) => t.isDone).toList();
  int get pendingCount => _tasks.where((t) => !t.isDone).length;

  /// Hanya mengambil data sekali agar status centang tidak ter-reset
  /// ketika beberapa halaman memanggil load().
  Future<void> load({bool refresh = false}) {
    if (_loaded && !refresh) return Future.value();
    return _inFlight ??= _fetch().whenComplete(() => _inFlight = null);
  }

  Future<void> _fetch() async {
    final json = await _service.fetchTasks();
    _tasks = json.map(Task.fromJson).toList();
    _loaded = true;
    notifyListeners();
  }

  /// Membalik status selesai sebuah tugas (memakai Task.copyWith).
  void toggleTask(String id) {
    _tasks = [
      for (final t in _tasks)
        if (t.id == id) t.copyWith(isDone: !t.isDone) else t,
    ];
    notifyListeners();
  }
}
