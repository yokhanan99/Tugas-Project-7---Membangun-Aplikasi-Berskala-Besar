import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/announcement_repository.dart';
import 'package:nusa_kampus/ui/announcements/announcements_view_model.dart';

import 'fakes.dart';

void main() {
  group('AnnouncementsViewModel', () {
    test('keadaan awal: kosong, tidak loading, tanpa error', () {
      final vm = AnnouncementsViewModel(
        repository: AnnouncementRepository(service: FakeCampusService()),
      );
      expect(vm.announcements, isEmpty);
      expect(vm.isLoading, isFalse);
      expect(vm.error, isNull);
    });

    test('load() sukses mengisi pengumuman (terbaru dulu) & isLoading kembali false',
        () async {
      final vm = AnnouncementsViewModel(
        repository: AnnouncementRepository(service: FakeCampusService()),
      );
      final loadingStates = <bool>[];
      vm.addListener(() => loadingStates.add(vm.isLoading));

      await vm.load();

      expect(loadingStates, [true, false]);
      expect(vm.announcements.length, 2);
      expect(vm.announcements.first.title, 'Pengumuman Baru');
      expect(vm.error, isNull);
    });

    test('load() gagal mengisi error', () async {
      final vm = AnnouncementsViewModel(
        repository: AnnouncementRepository(
          service: FakeCampusService(failAnnouncements: true),
        ),
      );

      await vm.load();

      expect(vm.error, isNotNull);
      expect(vm.isLoading, isFalse);
      expect(vm.announcements, isEmpty);
    });
  });
}
