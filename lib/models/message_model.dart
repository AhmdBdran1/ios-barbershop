class Message {
  final String title;
  final String content;
  final String date;

  Message({
    required this.title,
    required this.content,
    required this.date,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }
}