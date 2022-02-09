import 'dart:ffi';

class Zone {
  final int id;
  final String status;
  final String nom;
  final String description;
  final List coordonnees;

//Constructor
  const Zone(
      {required this.id,
      required this.status,
      required this.nom,
      required this.description,
      required this.coordonnees});

  //From Json
  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      status: json['status'],
      nom: json['nom'],
      description: json['description'],
      coordonnees: json['coordonnees'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'nom': nom,
      'description': description,
      'coordonnees': coordonnees
    };
  }

  //From Map
  static Zone fromMap(Map map) {
    Zone zone = Zone(
        id: map['id'],
        status: map['status'],
        nom: map['nom'],
        description: map['description'],
        coordonnees: map['coordonnees']);
    return zone;
  }

  //To string
  @override
  String toString() {
    return 'Zone{id: $id, name: $nom, status: $status, description: $description, coordonnees: $coordonnees}';
  }
}
