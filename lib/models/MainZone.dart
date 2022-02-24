import 'dart:convert';
import 'dart:ffi';

class MainZone {
  final int id;
  final String status;
  final String nom;
  final String description;
  final List coordonnees;

//Constructor
  const MainZone({
    required this.id,
    required this.status,
    required this.nom,
    required this.description,
    required this.coordonnees,
  });

  //From Json
  factory MainZone.fromJson(Map<String, dynamic> json) {
    return MainZone(
      id: json['id'],
      status: json['status'],
      nom: json['nom'],
      description: json['description'],
      coordonnees: json['coordonnees'],
    );
  }

  MainZone.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        status = res['status'],
        nom = res['nom'],
        description = res['description'],
        coordonnees = jsonDecode(res['coordonnees']);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'status': status,
      'nom': nom,
      'description': description,
      'coordonnees': coordonnees
    };
  }

  //To string
  @override
  String toString() {
    return 'MainZone{id: $id, name: $nom, status: $status, description: $description, coordonnees: $coordonnees}';
  }
}
