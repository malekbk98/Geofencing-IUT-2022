import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geofencing/models/Zone.dart';

import '../models/Article.dart';
import '../models/MainZone.dart';
import '../models/Spot.dart';

late List<Zone> zones;

class DatabaseHandler {
// Initiate database
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'geofencing.db'),
      onCreate: (database, version) async {
        //Create zones table
        await database.execute(
          'CREATE TABLE zones(id INTEGER PRIMARY KEY, nom TEXT, mainZoneId INTEGER,status TEXT, description TEXT, coordonnees JSON, image_header TEXT)',
        );

        //Create mainZones table
        await database.execute(
          'CREATE TABLE mainZones(id INTEGER PRIMARY KEY, nom TEXT, status TEXT, description TEXT, coordonnees JSON)',
        );

        //Create idUpdate table
        await database.execute(
          'CREATE TABLE updateDatas(id INTEGER PRIMARY KEY, idUpdate INTEGER, dateUpdate TEXT)',
        );

        //Insert default update id (0)
        await database.execute(
          'INSERT INTO updateDatas(idUpdate, dateUpdate) VALUES (0, CURRENT_TIMESTAMP)',
        );

        //Create Articles table
        await database.execute(
          'CREATE TABLE articles(id INTEGER PRIMARY KEY, title TEXT, author TEXT,content TEXT, img TEXT, spotId INTEGER DEFAULT NULL, zoneId INTEGER DEFAULT NULL, mainZoneId INTEGER DEFAULT NULL )',
        );

        //Create Spots table
        await database.execute(
          'CREATE TABLE spots(id INTEGER PRIMARY KEY, name TEXT,description TEXT, mainZoneId INTEGER, image_header TEXT)',
        );
      },
      version: 1,
    );
  }

//Reset table
  Future<int> resetDb() async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawDelete('DELETE FROM mainZones');
    result = await db.rawDelete('DELETE FROM zones');
    result = await db.rawDelete('DELETE FROM articles');
    result = await db.rawDelete('DELETE FROM spots');
    return result;
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
        'mainZoneId': zone.mainZoneId,
        'description': zone.description,
        'coordonnees': jsonEncode(zone.coordonnees),
        'image_header': zone.image_header,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  // Insert a spot
  Future<int> insertSpot(Spot spot) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(
      'spots',
      {
        'id': spot.id,
        'name': spot.name,
        'description': spot.description,
        'image_header': spot.image_header,
        'mainZoneId': spot.mainZoneId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //print(spot);

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
        'description': zone.description,
        'coordonnees': jsonEncode(zone.coordonnees),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

// Insert a zone
  Future<int> insertArticle(Article article) async {
    int result = 0;
    //print(article);

    final Database db = await initializeDB();
    result = await db.insert(
      'articles',
      {
        'id': article.id,
        'title': article.title,
        'content': article.content,
        'img': article.img,
        'spotId': article.spotId,
        'zoneId': article.zoneId,
        'mainZoneId': article.mainZoneId,
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

//Insert a idUpdate
  Future<int> insertIdUpdate(int id) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(
      'updateDatas',
      {'id': 12345, 'idUpdate': id, 'dateUpdate': DateTime.now().toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

// Get last idUpdate in sqflite
  Future<String> getLastIdUpdate() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResultId = await db
        .rawQuery('SELECT * FROM updateDatas ORDER BY idUpdate desc LIMIT 1');
    return queryResultId[0]['idUpdate'].toString();
  }

// Get last idUpdate in sqflite
  Future<String> getDateTimeOfLastIdUpdate() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResultId = await db
        .rawQuery('SELECT * FROM updateDatas ORDER BY idUpdate desc LIMIT 1');
    return queryResultId[0]['dateUpdate'].toString();
  }

//Count for empty DB or not
  Future<bool> dbIsEmptyOrNot() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('zones');
    return queryResult.isEmpty;
  }

  //Get article by zone id
  Future<List<Article>> getZoneArticles(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        'SELECT * FROM articles WHERE zoneId=? and mainZoneId IS NULL', [id]);
    return result.map((e) => Article.fromMap(e)).toList();
  }

  //Get article by mainZone id
  Future<String> getMainZoneArticle(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        'SELECT * FROM articles WHERE mainZoneId=? and zoneId IS NULL and spotId IS NULL',
        [id]);
    return result[0]['content'].toString();
  }

  //Get all spots
  Future<List<Spot>> getSpots() async {
    // Get a reference to the database.
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('spots');
    return queryResult.map((e) => Spot.fromMap(e)).toList();
  }

  Future<Spot> getSpot(String id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM spots WHERE id=?', [id]);
    return result.map((e) => Spot.fromMap(e)).toList()[0];
  }

  Future<List<Article>> getSpotArticle(String id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        'SELECT * FROM articles WHERE spotId=? and mainZoneId IS NULL', [id]);
    return result.map((e) => Article.fromMap(e)).toList();
  }
}
