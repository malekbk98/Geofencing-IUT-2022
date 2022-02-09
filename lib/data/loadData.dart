import 'dart:convert';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geofencing/data/DBHelper.dart' as dbHelper;

import 'DBHelper.dart';

late List<Zone> zones;
late Zone mainZone;

//Fetch main zone
void fetchMainZone() async {
  final response = await http.get(Uri.parse(
      'http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain?access_token=admin_token'));

  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'][0];
    var mainZone = Zone(
      id: data['id'],
      status: data['status'],
      nom: data['nom'],
      description: data['description'],
      coordonnees: data['coordonnees']['coordinates'][0],
    );

    //Add to storage (to remove )
    final LocalStorage storage = new LocalStorage('geofencing');
    storage.setItem('mainZone', mainZone);

    mainZone = mainZone;
  } else {
    throw Exception('Failed to load main zone');
  }
}

//Fetch all zones
void fetchZones() async {
  final response = await http.get(Uri.parse(
      'http://docketu.iutnc.univ-lorraine.fr:62000/items/zone?access_token=admin_token'));
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
    final LocalStorage storage = new LocalStorage('geofencing');
    storage.setItem('zones', tempZones);

    zones = tempZones;
  } else {
    throw Exception('Failed to load zones');
  }
}

initData() {
  try {
    dbHelper.main();
    //Load main zone
    fetchMainZone();
    //Load all zones
    fetchZones();
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
