import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:geofencing/models/Zone.dart';

var database;

late List<Zone> zones;

Future<void> initDb() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await openDatabase(
    join(await getDatabasesPath(), 'geofencing.db'),
    // When the database is first created, create a table to store zones.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE zones(id INTEGER PRIMARY KEY, nom TEXT, type TEXT,status TEXT, description TEXT, coordonnees JSON)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

// Insert a zone
Future<void> insertZone(Zone zone) async {
  final db = await database;
  await db.insert(
    'zones',
    {
      'id': zone.id,
      'nom': zone.nom,
      'status': zone.status,
      'type': zone.type,
      'description': zone.description,
      'coordonnees': jsonEncode(zone.coordonnees),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//Get all zones
Future<List<Zone>> getZones() async {
  // Get a reference to the database.
  final db = await database;

  return db.query('zones').then((List<Map<String, dynamic>> maps) {
    print(maps[0]);
    List.generate(maps.length, (i) {
      return Zone(
          id: maps[i]['id'],
          status: maps[i]['status'],
          nom: maps[i]['nom'],
          type: maps[i]['type'],
          description: maps[i]['description'],
          coordonnees: jsonDecode(maps[i]['coordonnees']));
    });
  });
}
