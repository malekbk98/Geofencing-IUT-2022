import 'dart:convert';

class Zone {
  final int id;
  final String status;
  final String nom;
  final int mainZoneId;
  final String description;
  final List coordonnees;

//Constructor
  const Zone({
    required this.id,
    required this.status,
    required this.nom,
    required this.mainZoneId,
    required this.description,
    required this.coordonnees,
  });

  //From Json
  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      status: json['status'],
      mainZoneId: json['mainZoneId'],
      nom: json['nom'],
      description: json['description'],
      coordonnees: json['coordonnees'],
    );
  }

  Zone.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        status = res['status'],
        nom = res['nom'],
        mainZoneId = res['mainZoneId'],
        description = res['description'],
        coordonnees = jsonDecode(res['coordonnees']);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'status': status,
      'nom': nom,
      'mainZoneId': mainZoneId,
      'description': description,
      'coordonnees': coordonnees
    };
  }

  //To string
  @override
  String toString() {
    return 'Zone{id: $id, name: $nom, status: $status, mainZoneId: $mainZoneId, description: $description, coordonnees: $coordonnees}';
  }
}
