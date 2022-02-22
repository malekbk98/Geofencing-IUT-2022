import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geofencing/models/Zone.dart';

import '../models/MainZone.dart';

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
        await database.execute(
          'CREATE TABLE mainZones(id INTEGER PRIMARY KEY, nom TEXT, type TEXT,status TEXT, description TEXT, coordonnees JSON)',
        );
        await database.execute(
          'CREATE TABLE idUpdate(id INTEGER PRIMARY KEY, idUpdate INTEGER)',
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

// Insert main zone
  Future<int> insertMainZone(MainZone zone) async {
    int result = 0;
    final Database db = await initializeDB();

    result = await db.insert(
      'mainZones',
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

//Get main zones
  Future<List<MainZone>> getMainZones() async {
    // Get a reference to the database.
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('mainZones');
    return queryResult.map((e) => MainZone.fromMap(e)).toList();
  }

// Insert a idUpdate
  Future<int> insertIdUpdate(int id) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(
      'idUpdate',
      {
        'id': 12345,
        'idUpdate': id,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(id);

    return result;
  }

// Get last idUpdate in sqflite
  Future<Object?> getLastIdUpdate() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResultId = await db
        .rawQuery('SELECT * FROM idUpdate ORDER BY idUpdate desc LIMIT 1');
    print('Local DB last id update ${queryResultId[0]['idUpdate']}');
    return queryResultId[0]['idUpdate'];
  }

//Count for empty DB or not
  Future<Object?> dbIsEmptyOrNot() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('zones');
    return queryResult.length;
  }
}
