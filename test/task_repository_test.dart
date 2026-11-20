import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/task_repository.dart';

import 'fakes.dart';

void main() {
  test('toggleTask memindahkan tugas ke selesai dan memberi notifikasi', () async {
    final repo = TaskRepository(service: FakeCampusService());
    await repo.load();
    expect(repo.pendingCount, 2);

    var notified = 0;
    repo.addListener(() => notified++);

    repo.toggleTask('t1');

    expect(notified, 1);
    expect(repo.pendingCount, 1);
    expect(repo.doneTasks.single.id, 't1');

    repo.toggleTask('t1');
    expect(repo.pendingCount, 2);
  });

  test('load() kedua tidak me-reset status centang', () async {
    final repo = TaskRepository(service: FakeCampusService());
    await repo.load();
    repo.toggleTask('t2');
    await repo.load();
    expect(repo.doneTasks.single.id, 't2');
  });
}
