import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/services/notification_service.dart';
import 'package:geofencing/widgets/map.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:geofencing/services/user_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _streamController = StreamController<PolyGeofence>();
  late DatabaseHandler handler;
  late List<PolyGeofence> zonesList = [];
  String content = "";
  String mainZoneContent = "";
  String lastNotif = "";

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 5000,
      accuracy: 1000,
      loiteringDelayMs: 500,
      statusChangeDelayMs: 500,
      allowMockLocations: true,
      printDevLog: true);

  // Check zone entry / exit
  Future<void> _onPolyGeofenceStatusChanged(PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus, Location location) async {
    String status =
        polyGeofenceStatus.toString().replaceAll('PolyGeofenceStatus.', '');
    String res = "";
    if (status == "EXIT") {
      //**********************User exit zone*****************************

      //Return default info (main zone info)
      res = mainZoneContent;
    } else {
      //**********************User enter zone*****************************

      //Return current zone info
      res = polyGeofence.data['content'];
      // Getting notified after entering orgoing out of a zone
      UserPreferences().getNotificationsPreferences('notifications').then(
        (value) {
          if (value! && polyGeofence.data['name'] != lastNotif) {
            //To ignore showing the same notification when position changes
            lastNotif = polyGeofence.data['name'];
            NotificationService().showNotification(
              Random().nextInt(99999),
              polyGeofence.data['name'],
              polyGeofence.data['description'],
            );
          }
        },
      );
    }

    //Update state
    setState(() {
      content = res;
    });
  }

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      //Get all zones from db
      var zones = await handler.getZones();

      //Main zone id (get this from zones)
      int mainZoneId = -1;

      for (var zone in zones) {
        late List<LatLng> pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(LatLng(item[1], item[0]));
        }

        //Concatenate all article togethers
        var articles = await handler.getZoneArticles(zone.id);
        var article = "";
        for (var a in articles) {
          article = article + a.content;
        }

        //Get mainZone id from zone
        if (mainZoneId == -1) {
          mainZoneId = zone.mainZoneId;
        }

        //Add to zone list (to use it in the detection)
        zonesList.add(
          PolyGeofence(
            id: zone.id.toString(),
            data: {
              'name': zone.nom,
              'description': zone.description,
              'content': article,
            },
            polygon: pointsList,
          ),
        );
        //Update state
        setState(() {});
      }

      //Get mainZone details (default display)
      mainZoneContent = await handler.getMainZoneArticle(mainZoneId);

      //Update state
      setState(() {
        content = mainZoneContent;
      });

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _polyGeofenceService
            .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
        _polyGeofenceService.start(zonesList);
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            const Card(
              child: SizedBox(
                height: 250,
                child: MapWidget(),
              ),
            ),
            Expanded(
              child: Markdown(
                data: content,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
