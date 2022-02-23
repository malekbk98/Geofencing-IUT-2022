import 'dart:convert';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;

import '../models/MainZone.dart';

late Future<List<Zone>> zones;
late Future<MainZone> mainZone;
late DatabaseHandler handler;

String uriMainZone =
    'http://docketu.iutnc.univ-lorraine.fr:62007/items/terrain?access_token=public_mine_token';
String uriZones =
    'http://docketu.iutnc.univ-lorraine.fr:62007/items/zone?access_token=public_mine_token';

//Fetch main zone
Future<MainZone> fetchMainZone() async {
  final response = await http.get(Uri.parse(uriMainZone));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'][0];
    var mainZone = MainZone(
      id: data['id'],
      status: data['status'],
      nom: data['nom'],
      type: "mainZone",
      description: data['description'],
      coordonnees: data['coordonnees']['coordinates'][0],
    );

    //Add to db
    handler.initializeDB().whenComplete(() async {
      handler.insertMainZone(mainZone);
    });
    return mainZone;
  } else {
    throw Exception('Failed to load main zone');
  }
}

//Fetch all zones
Future<List<Zone>> fetchZones() async {
  final response = await http.get(Uri.parse(uriZones));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'];
    List<Zone> tempZones = [];
    for (var zone in data) {
      var temp = Zone(
        id: zone['id'],
        status: zone['status'],
        nom: zone['nom'],
        type: "zone",
        description: zone['description'],
        coordonnees: zone['coordonnees']['coordinates'][0],
      );

      //Add to return
      tempZones.add(temp);

      //Add to db
      handler.initializeDB().whenComplete(() async {
        handler.insertZone(temp);
      });
    }
    return tempZones;
  } else {
    throw Exception('Failed to load zones');
  }
}

//Check internet connection

initData() {
  try {
    /**
     * Load from APIs
     */
    //Load main zone
    handler = DatabaseHandler();

    mainZone = fetchMainZone();

    //Load all zones
    zones = fetchZones();
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
