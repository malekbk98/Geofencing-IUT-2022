import 'dart:convert';

class Zone {
  final int id;
  final String status;
  final String nom;
  final String type;
  final String description;
  final List coordonnees;
  final String image_header;

//Constructor
  const Zone(
      {required this.id,
      required this.status,
      required this.nom,
      required this.type,
      required this.description,
      required this.coordonnees,
      required this.image_header});

  //From Json
  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
        id: json['id'],
        status: json['status'],
        type: json['type'],
        nom: json['nom'],
        description: json['description'],
        coordonnees: json['coordonnees'],
        image_header: json['image_header']);
  }

  Zone.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        status = res['status'],
        nom = res['nom'],
        type = res['type'],
        description = res['description'],
        coordonnees = jsonDecode(res['coordonnees']),
        image_header = res['image_header'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'status': status,
      'nom': nom,
      'type': type,
      'description': description,
      'coordonnees': coordonnees,
      'image_header': image_header
    };
  }

  //To string
  @override
  String toString() {
    return 'Zone{id: $id, name: $nom, status: $status, type: $type, description: $description, coordonnees: $coordonnees, image_header: $image_header}';
  }
}
