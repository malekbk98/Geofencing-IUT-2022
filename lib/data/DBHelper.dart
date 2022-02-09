import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:geofencing/models/Zone.dart';

var database;

initDb() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
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

// Define a function that inserts dogs into the database
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
Future<List<Zone>> zones() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('zones');

  // Convert the List<Map<String, dynamic> into a List<Zone>.
  return List.generate(maps.length, (i) {
    return Zone(
        id: maps[i]['id'],
        status: maps[i]['status'],
        nom: maps[i]['nom'],
        type: maps[i]['type'],
        description: maps[i]['description'],
        coordonnees: jsonDecode(maps[i]['coordonnees']));
  });
}

//Get main zone
Future<Zone> getMainZone() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('zones');
  print(maps[0]['id']);
  return Zone(
    id: maps[0]['id'],
    status: maps[0]['status'],
    nom: maps[0]['nom'],
    type: maps[0]['type'],
    description: maps[0]['description'],
    coordonnees: jsonDecode(maps[0]['coordonnees']),
  );
}
