import 'dart:convert';

class Article {
  final int id;
  final String title;
  final String author;
  final String content;
  final String? img;
  final int? spotId;
  final int? zoneId;

//Constructor
  const Article({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.img,
    required this.spotId,
    required this.zoneId,
  });

  //From Json
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      content: json['content'],
      img: json['img'],
      spotId: json['spotId'],
      zoneId: json['zoneId'],
    );
  }

  Article.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res['title'],
        author = res['author'],
        content = res['content'],
        img = res['img'],
        spotId = res['spotId'],
        zoneId = res['zoneId'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'content': content,
      'img': img,
      'spotId': spotId,
      'zoneId': zoneId,
    };
  }

  //To string
  @override
  String toString() {
    return 'Article{id: $id, title: $title, author: $author, content: $content, img: $img, spotId: $spotId, zoneId: $zoneId}';
  }
}
