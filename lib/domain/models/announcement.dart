class Announcement {
  final String id;
  final String title;
  final String body;
  final String author;
  final DateTime date;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.date,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      author: json['author'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
