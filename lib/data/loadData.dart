import 'dart:async';
import 'dart:convert';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/models/Article.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;

import '../models/MainZone.dart';

late Future<List<Zone>> zones;
late Future<MainZone> mainZone;
late DatabaseHandler handler;

late Future<int> idUpdate;
late Object? getId;

bool dbIsEmpty = false;
int port = 62007;

String uriMainZone =
    'http://docketu.iutnc.univ-lorraine.fr:${port}/items/terrain?access_token=public_mine_token';
String uriZones =
    'http://docketu.iutnc.univ-lorraine.fr:${port}/items/zone?access_token=public_mine_token';
String uriArticles =
    'http://docketu.iutnc.univ-lorraine.fr:${port}/items/article?access_token=public_mine_token';
String checkIdUpdate =
    'http://docketu.iutnc.univ-lorraine.fr:${port}/revisions?sort=-id&limit=1&access_token=public_mine_token';

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

//Fetch all articles
Future<List<Article>> fetchArticles() async {
  final response = await http.get(Uri.parse(uriArticles));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'];
    List<Article> articles = [];
    for (var art in data) {
      if (art['status'] == 'published') {
        var article = Article(
          id: art['id'],
          title: art['titre'],
          author: art['auteur'],
          content: art['contenu'],
          img: art['image_header'],
          spotId: art['borne'],
          zoneId: art['zone'],
        );

        //Add to return
        articles.add(article);
        //Add to db
        handler.initializeDB().whenComplete(() async {
          handler.insertArticle(article);
        });
      }
    }
    return articles;
  } else {
    throw Exception('Failed to load zones');
  }
}

//Fetch number of id about checkUpdate
Future<bool> fetchIdUpdate() async {
  late bool res;
  final response = await http.get(Uri.parse(checkIdUpdate));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    String idUpdate = jsonDecode(response.body)['data'][0]['id'].toString();

    //get ID from db local
    await handler.initializeDB();
    String getId = await handler.getLastIdUpdate();
    if (getId == null) {
    } else {
      if (getId != idUpdate) {
        res = true;
      } else {
        res = false;
      }
    }
    return res;
  } else {
    throw Exception('Failed to fetch ID');
  }
}

Future insertId() async {
  final response = await http.get(Uri.parse(checkIdUpdate));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    int idUpdate = jsonDecode(response.body)['data'][0]['id'];

    //get ID from db local
    handler.initializeDB().whenComplete(() async {
      await handler.insertIdUpdate(idUpdate);
    });
  } else {
    throw Exception('Failed to insert ID');
  }
}
//Check internet connection

initData() {
  try {
    /**
     * Load from APIs
     */
    handler = DatabaseHandler();
    //Check db status (empty/not)
    handler.dbIsEmptyOrNot().then((dbCheck) async {
      //Check data version
      bool updateCheck = await fetchIdUpdate();
      if (dbCheck || updateCheck) {
        await handler.resetDb();

        //Load main zone
        await fetchMainZone();

        //Load all zones
        await fetchZones();

        //Load all articles
        await fetchArticles();

        //Update last change id
        insertId();
      }
    });
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
