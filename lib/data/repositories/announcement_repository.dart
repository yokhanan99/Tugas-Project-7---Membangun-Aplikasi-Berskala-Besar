import '../../domain/models/announcement.dart';
import '../services/campus_service.dart';

class AnnouncementRepository {
  AnnouncementRepository({required CampusService service})
      : _service = service;

  final CampusService _service;

  Future<List<Announcement>> fetchAnnouncements() async {
    final json = await _service.fetchAnnouncements();
    final list = json.map(Announcement.fromJson).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return list;
  }
}
