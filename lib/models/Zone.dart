class Zone {
  final int id;
  final String status;
  final String nom;
  final String description;
  final Object coordonnees;

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
}
