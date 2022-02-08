import 'dart:convert';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;

late List<Zone> zones;
late Zone mainZone;

//Fetch main zone
Future<Zone> fetchMainZone() async {
  final response = await http.get(
      Uri.parse('http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain'));

  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'][0];
    return Zone(
      id: data['id'],
      status: data['status'],
      nom: data['nom'],
      description: data['description'],
      coordonnees: data['coordonnees']['coordinates'][0],
    );
  } else {
    throw Exception('Failed to load main zone');
  }
}

//Fetch all zones
Future<List<Zone>> fetchZones() async {
  final response = await http
      .get(Uri.parse('http://docketu.iutnc.univ-lorraine.fr:62000/items/zone'));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    List<Zone> tempZones = [];
    var data = jsonDecode(response.body)['data'];
    for (var zone in data) {
      tempZones.add(Zone(
        id: zone['id'],
        status: zone['status'],
        nom: zone['nom'],
        description: zone['description'],
        coordonnees: zone['coordonnees']['coordinates'][0],
      ));
    }
    return tempZones;
  } else {
    throw Exception('Failed to load zones');
  }
}

initData() {
  //Load main zone
  try {
    mainZone = fetchMainZone() as Zone;
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }

  //Load all zones
  try {
    zones = fetchZones() as List<Zone>;
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
