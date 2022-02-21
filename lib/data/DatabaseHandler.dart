import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geofencing/models/Zone.dart';

late List<Zone> zones;

class DatabaseHandler {
// Initiate database
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'geofencing.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE zones(id INTEGER PRIMARY KEY, nom TEXT, type TEXT,status TEXT, description TEXT, coordonnees JSON)',
        );
      },
      version: 1,
    );
  }

// Insert a zone
  Future<int> insertZone(Zone zone) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(
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

    return result;
  }

//Get all zones
  Future<List<Zone>> getZones() async {
    // Get a reference to the database.
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('zones');
    return queryResult.map((e) => Zone.fromMap(e)).toList();
  }
}
