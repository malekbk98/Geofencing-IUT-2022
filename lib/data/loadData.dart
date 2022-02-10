import 'dart:convert';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geofencing/data/DBHelper.dart' as dbHelper;

import 'DBHelper.dart';

late List<Zone> zones;
late Zone mainZone;
late Database db;

//Fetch main zone
void fetchMainZone() async {
  final response = await http.get(Uri.parse(
      'http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain?access_token=public_mine_token'));

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
    dbHelper.insertZone(mainZone);
  } else {
    throw Exception('Failed to load main zone');
  }
}

//Fetch all zones
void fetchZones() async {
  final response = await http.get(Uri.parse(
      'http://docketu.iutnc.univ-lorraine.fr:62000/items/zone?access_token=public_mine_token'));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    List<Zone> tempZones = [];
    var data = jsonDecode(response.body)['data'];
    for (var zone in data) {
      var temp = Zone(
        id: zone['id'],
        status: zone['status'],
        nom: zone['nom'],
        type: "zone",
        description: zone['description'],
        coordonnees: zone['coordonnees']['coordinates'][0],
      );

      //Add to db
      dbHelper.insertZone(temp);
    }
  } else {
    throw Exception('Failed to load zones');
  }
}

initData() {
  try {
    //Init database
    dbHelper.initDb();

    /**
     * Load from APIs
     */
    //Load main zone
    fetchMainZone();
    //Load all zones
    fetchZones();
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
