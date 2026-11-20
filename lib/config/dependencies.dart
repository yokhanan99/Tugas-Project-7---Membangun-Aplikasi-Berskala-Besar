import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/announcement_repository.dart';
import '../data/repositories/schedule_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/services/campus_service.dart';

/// Daftar semua provider (service + repository) untuk [MultiProvider].
/// Parameter [service] opsional, dipakai agar mudah diganti fake saat testing.
List<SingleChildWidget> buildProviders({CampusService? service}) {
  return [
    Provider<CampusService>(create: (_) => service ?? CampusService()),
    Provider<ScheduleRepository>(
      create: (context) =>
          ScheduleRepository(service: context.read<CampusService>()),
    ),
    // TaskRepository adalah ChangeNotifier -> Beranda & badge ikut berubah.
    ChangeNotifierProvider<TaskRepository>(
      create: (context) =>
          TaskRepository(service: context.read<CampusService>()),
    ),
    Provider<AnnouncementRepository>(
      create: (context) =>
          AnnouncementRepository(service: context.read<CampusService>()),
    ),
  ];
}
