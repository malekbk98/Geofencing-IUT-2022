import 'dart:convert';

class Article {
  final int id;
  final String? title;
  final String content;
  final String? img;
  final int? spotId;
  final int? zoneId;
  final int? mainZoneId;

//Constructor
  const Article({
    required this.id,
    required this.title,
    required this.content,
    this.img,
    required this.spotId,
    required this.zoneId,
    required this.mainZoneId,
  });

  //From Json
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      img: json['img'],
      spotId: json['spotId'],
      zoneId: json['zoneId'],
      mainZoneId: json['mainZoneId'],
    );
  }

  Article.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res['title'],
        content = res['content'],
        img = res['img'],
        spotId = res['spotId'],
        zoneId = res['zoneId'],
        mainZoneId = res['mainZoneId'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'img': img,
      'spotId': spotId,
      'zoneId': zoneId,
      'mainZoneId': mainZoneId,
    };
  }

  //To string
  @override
  String toString() {
    return 'Article{id: $id, title: $title, content: $content, img: $img, spotId: $spotId, zoneId: $zoneId, mainZoneId: $mainZoneId}';
  }
}
