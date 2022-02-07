class Zone {
  final int id;
  final String description;
  final Object coordonnees;

//Constructor
  const Zone(
      {required this.id, required this.description, required this.coordonnees});

  //From Json
  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      description: json['description'],
      coordonnees: json['coordonnees'],
    );
  }
}
