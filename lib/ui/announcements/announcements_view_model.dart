import '../../data/repositories/announcement_repository.dart';
import '../../domain/models/announcement.dart';
import '../core/view_model.dart';

class AnnouncementsViewModel extends ViewModel {
  AnnouncementsViewModel({required AnnouncementRepository repository})
      : _repository = repository;

  final AnnouncementRepository _repository;

  List<Announcement> _announcements = const [];
  List<Announcement> get announcements => _announcements;

  Future<void> load() => runLoad(() async {
        _announcements = await _repository.fetchAnnouncements();
      });
}
