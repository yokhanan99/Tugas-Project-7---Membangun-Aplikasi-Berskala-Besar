const dayNames = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

const _months = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

String formatDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

String formatFullDate(DateTime d) =>
    '${dayNames[d.weekday - 1]}, ${formatDate(d)}';

/// Label tenggat: Terlambat / Hari ini / Besok / tanggal.
String dueLabel(DateTime due) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dueDay = DateTime(due.year, due.month, due.day);
  final diff = dueDay.difference(today).inDays;
  if (diff < 0) return 'Terlambat';
  if (diff == 0) return 'Hari ini';
  if (diff == 1) return 'Besok';
  return formatDate(due);
}
