import 'dart:async';
import 'dart:convert';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/models/Article.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:http/http.dart' as http;

import '../models/MainZone.dart';
import '../models/Spot.dart';
import '../services/check_connection.dart';

late Future<List<Zone>> zones;
late Future<MainZone> mainZone;
late DatabaseHandler handler;

late Future<int> idUpdate;
late Object? getId;

bool dbIsEmpty = false;
int port = 62090;
String token = "access_token=public_mine_token";
String apiUri = "http://docketu.iutnc.univ-lorraine.fr";

String uriMainZone = '${apiUri}:${port}/items/terrain?${token}';
String uriZones = '${apiUri}:${port}/items/zone?${token}';
String uriArticles = '${apiUri}:${port}/items/article?${token}';
String uriSpots = '${apiUri}:${port}/items/borne?${token}';
String checkIdUpdate = '${apiUri}:${port}/revisions?sort=-id&limit=1&${token}';

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
          mainZoneId: zone['terrain'],
          description: zone['description'],
          coordonnees: zone['coordonnees']['coordinates'][0],
          image_header: zone['image_header']);

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

    //Init db
    await handler.initializeDB();

    List<Article> articles = [];
    for (var art in data) {
      if (art['status'] == 'published') {
        var article = Article(
          id: art['id'],
          title: art['titre'],
          content: art['contenu'],
          img: art['image_header'],
          spotId: art['borne'],
          zoneId: art['zone'],
          mainZoneId: art['terrain'],
        );
        //Add to return
        articles.add(article);

        //Add to db
        handler.insertArticle(article);
      }
    }
    return articles;
  } else {
    throw Exception('Failed to load articles');
  }
}

//Fetch all spots
Future<List<Spot>> fetchSpots() async {
  final response = await http.get(Uri.parse(uriSpots));
  if (response.statusCode == 200) {
    //Save result (need to be stored in cache later)
    var data = jsonDecode(response.body)['data'];

    //Init db
    await handler.initializeDB();

    List<Spot> spots = [];
    for (var s in data) {
      if (s['status'] == 'published') {
        var spot = Spot(
          id: s['id'],
          name: s['nom'],
          description: s['description'],
          mainZoneId: s['terrain'],
        );
        //Add to return
        spots.add(spot);

        //Add to db
        handler.insertSpot(spot);
      }
    }
    return spots;
  } else {
    throw Exception('Failed to load spots');
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
    return false;
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

//Load from APIs
initData() async {
  late bool updateCheck;
  try {
    handler = DatabaseHandler();
    //Check db status (empty/not)
    bool dbCheck = await handler.dbIsEmptyOrNot();

    //Check data version
    bool cnxCheck = await CheckConnection.initializeCheck();

    if (cnxCheck == true) {
      updateCheck = await fetchIdUpdate();
      dbCheck = false;
    } else {
      updateCheck = false;
      dbCheck = false;
    }

    if (dbCheck || updateCheck) {
      //Dump all tables
      await handler.resetDb();

      //Load main zone
      await fetchMainZone();

      //Load all zones
      await fetchZones();

      //Load all articles
      await fetchArticles();

      //Load all spots
      await fetchSpots();

      //Update last change id
      await insertId();
    }

    return true;
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
