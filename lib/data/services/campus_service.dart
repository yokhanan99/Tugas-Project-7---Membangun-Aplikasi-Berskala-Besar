/// Simulasi server: mengembalikan data contoh (JSON) setelah jeda waktu.
class CampusService {
  static const _delay = Duration(milliseconds: 800);

  Future<List<Map<String, dynamic>>> fetchCourses() async {
    await Future.delayed(_delay);
    return [
      // Senin
      _course('c1', 'Pemrograman Mobile', 'Dr. Andi Wijaya', 'Lab 3', 1, '08:00', '10:30'),
      _course('c2', 'Basis Data', 'Ir. Sari Lestari', 'R. 204', 1, '13:00', '15:00'),
      // Selasa
      _course('c3', 'Jaringan Komputer', 'Budi Santoso, M.Kom', 'Lab 1', 2, '09:00', '11:30'),
      _course('c4', 'Statistika', 'Dr. Rina Putri', 'R. 101', 2, '13:00', '14:40'),
      // Rabu
      _course('c5', 'Rekayasa Perangkat Lunak', 'Dr. Hendra Gunawan', 'R. 305', 3, '08:00', '10:00'),
      _course('c6', 'Kecerdasan Buatan', 'Prof. Maya Anggraini', 'Lab 2', 3, '10:30', '12:30'),
      // Kamis
      _course('c7', 'Sistem Operasi', 'Eko Prasetyo, M.T.', 'R. 207', 4, '08:00', '09:40'),
      _course('c8', 'Interaksi Manusia & Komputer', 'Dewi Kartika, M.Ds.', 'R. 110', 4, '13:00', '15:00'),
      // Jumat
      _course('c9', 'Pendidikan Pancasila', 'Drs. Fajar Nugroho', 'R. 001', 5, '08:00', '09:40'),
      _course('c10', 'Etika Profesi', 'Lina Marlina, M.Si.', 'R. 102', 5, '10:00', '11:40'),
    ];
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    await Future.delayed(_delay);
    final now = DateTime.now();
    String due(int days) => now.add(Duration(days: days)).toIso8601String();
    return [
      {'id': 't1', 'title': 'Laporan Praktikum Flutter', 'courseName': 'Pemrograman Mobile', 'dueDate': due(1), 'isDone': false},
      {'id': 't2', 'title': 'Rancangan ERD Perpustakaan', 'courseName': 'Basis Data', 'dueDate': due(2), 'isDone': false},
      {'id': 't3', 'title': 'Konfigurasi Router Cisco', 'courseName': 'Jaringan Komputer', 'dueDate': due(3), 'isDone': false},
      {'id': 't4', 'title': 'Latihan Soal Distribusi Normal', 'courseName': 'Statistika', 'dueDate': due(4), 'isDone': false},
      {'id': 't5', 'title': 'Dokumen SRS Proyek Akhir', 'courseName': 'Rekayasa Perangkat Lunak', 'dueDate': due(5), 'isDone': false},
      {'id': 't6', 'title': 'Esai Nilai-nilai Pancasila', 'courseName': 'Pendidikan Pancasila', 'dueDate': due(7), 'isDone': false},
    ];
  }

  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    await Future.delayed(_delay);
    final now = DateTime.now();
    String ago(int days) => now.subtract(Duration(days: days)).toIso8601String();
    return [
      {
        'id': 'a1',
        'title': 'Jadwal UTS Semester Ganjil',
        'body': 'UTS akan dilaksanakan pada minggu ke-8 perkuliahan. Jadwal lengkap dapat dilihat di portal akademik masing-masing.',
        'author': 'Bagian Akademik',
        'date': ago(0),
      },
      {
        'id': 'a2',
        'title': 'Pendaftaran Beasiswa Prestasi',
        'body': 'Beasiswa prestasi dibuka hingga akhir bulan ini. Persyaratan: IPK minimal 3,50 dan surat rekomendasi dosen.',
        'author': 'Biro Kemahasiswaan',
        'date': ago(1),
      },
      {
        'id': 'a3',
        'title': 'Perpustakaan Buka Sampai Malam',
        'body': 'Selama masa ujian, perpustakaan pusat buka sampai pukul 21.00 WIB setiap hari kerja.',
        'author': 'Perpustakaan Pusat',
        'date': ago(3),
      },
      {
        'id': 'a4',
        'title': 'Seminar Nasional Teknologi Informasi',
        'body': 'Ikuti seminar nasional bersama praktisi industri di Aula Utama. Gratis untuk seluruh mahasiswa, mohon daftar terlebih dahulu.',
        'author': 'HIMA Informatika',
        'date': ago(5),
      },
    ];
  }

  Map<String, dynamic> _course(String id, String name, String lecturer,
      String room, int day, String start, String end) {
    return {
      'id': id,
      'name': name,
      'lecturer': lecturer,
      'room': room,
      'day': day,
      'startTime': start,
      'endTime': end,
    };
  }
}
