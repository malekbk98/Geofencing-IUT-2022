import 'dart:convert';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;

late Future<List<Zone>> zones;
late Future<Zone> mainZone;
late DatabaseHandler handler;
late Future<int> idUpdate;

String uriMainZone =
    'http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain?access_token=public_mine_token';
String uriZones =
    'http://docketu.iutnc.univ-lorraine.fr:62000/items/zone?access_token=public_mine_token';
String checkIdUpdate =
    'http://docketu.iutnc.univ-lorraine.fr:62000/revisions?sort=-id&limit=1&access_token=public_mine_token';

//Fetch main zone
Future<Zone> fetchMainZone() async {
  final response = await http.get(Uri.parse(uriMainZone));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'][0];
    var mainZone = Zone(
      id: data['id'],
      status: data['status'],
      nom: data['nom'],
      type: "mainZone",
      description: data['description'],
      coordonnees: data['coordonnees']['coordinates'][0],
    );

    //Add to db
    handler.initializeDB().whenComplete(() async {
      print("mainZoneGetFromAPI");
      handler.insertZone(mainZone);
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

//Fetch number of id about checkUpdate
Future<int> fetchIdUpdate() async {
  final response = await http.get(Uri.parse(checkIdUpdate));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var idUpdate = jsonDecode(response.body)['data'][0]['id'];
    print("fetch idUpdate GET from API : $idUpdate");

    //Add to db
    handler.initializeDB().whenComplete(() async {
      print("fetch idUpdate GET from API");
      handler.insertIdUpdate(idUpdate);
    });
    return idUpdate;
  } else {
    throw Exception('Failed to load main zone');
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

    //load idUpdate
    idUpdate = fetchIdUpdate();
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
