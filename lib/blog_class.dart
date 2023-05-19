class Blog {
  final String title;
  final String text;
  final String author;
  final String docID;

  Blog({
    required this.title,
    required this.text,
    required this.author,
    required this.docID,
  });

  static Blog fromJson(Map<String, dynamic> json) => Blog(
        title: json['title'],
        text: json['text'],
        author: json['author'],
        docID: json['docID'],
      );
}
