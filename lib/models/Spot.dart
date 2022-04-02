import 'dart:convert';

class Spot {
  final int id;
  final String name;
  final String description;
  final String? image_header;
  final int? mainZoneId;

//Constructor
  const Spot({
    required this.id,
    required this.name,
    required this.description,
    this.image_header,
    required this.mainZoneId,
  });

  //From Json
  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image_header: json['image_header'],
      mainZoneId: json['mainZoneId'],
    );
  }

  Spot.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res['name'],
        description = res['description'],
        image_header = res['image_header'],
        mainZoneId = res['mainZoneId'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_header': image_header,
      'mainZoneId': mainZoneId,
    };
  }

  //To string
  @override
  String toString() {
    return 'Spot{id: $id, name: $name, description: $description, image_header: $image_header, mainZoneId: $mainZoneId}';
  }
}
