import 'dart:convert';

class Spot {
  final int id;
  final String name;
  final String description;
  final int? mainZoneId;

//Constructor
  const Spot({
    required this.id,
    required this.name,
    required this.description,
    required this.mainZoneId,
  });

  //From Json
  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      mainZoneId: json['mainZoneId'],
    );
  }

  Spot.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res['name'],
        description = res['description'],
        mainZoneId = res['mainZoneId'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'mainZoneId': mainZoneId,
    };
  }

  //To string
  @override
  String toString() {
    return 'Spot{id: $id, name: $name, description: $description, mainZoneId: $mainZoneId}';
  }
}
