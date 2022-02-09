import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:geofencing/models/Zone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'geofencing.db'),
    // When the database is first created, create a table to store zones.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE zones(id INTEGER PRIMARY KEY, nom TEXT, status TEXT, description TEXT, coordonnees JSON)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertZone(Zone zone) async {
    final db = await database;
    print('im here');
    await db.insert(
      'zones',
      {
        'id': zone.id,
        'nom': zone.nom,
        'status': zone.status,
        'description': zone.description,
        'coordonnees': jsonEncode(zone.coordonnees),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Zone>> zones() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('zones');

    // Convert the List<Map<String, dynamic> into a List<Zone>.
    return List.generate(maps.length, (i) {
      print(jsonDecode(maps[i]['coordonnees']));
      return Zone(
          id: maps[i]['id'],
          status: maps[i]['status'],
          nom: maps[i]['nom'],
          description: maps[i]['description'],
          coordonnees: jsonDecode(maps[i]['coordonnees']));
    });
  }

  // Create a Dog and add it to the zones table
  var zone1 = const Zone(
      id: 0,
      nom: 'zone1',
      status: '35',
      description: '35',
      coordonnees: ['656', '656xs']);

  await insertZone(zone1);

  print(await zones());
}
