import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:latlong2/latlong.dart' as lat;

import '../data/DatabaseHandler.dart';
import '../models/MainZone.dart';
import '../models/Zone.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late List<Polygon> allZones = [];
  late List<Zone> zoneList = [];
  late List<MainZone> mainZoneList = [];
  late List<Polygon> zones = [];
  late List<lat.LatLng> mainPointsList = [];
  late List<lat.LatLng> pointsList = [];
  final MapController mapController = MapController();
  late DatabaseHandler handler;
  late double mainZonelat;
  late double mainZonelong;

  @override
  void initState() {
    super.initState();

    //Get main zone coordinates
    rootBundle
        .loadString(
      'assets/config/config.json',
    )
        .then((value) {
      final config = jsonDecode(value);
      setState(() {
        mainZonelat = config['mainZonelat'];
        mainZonelong = config['mainZonelong'];
      });
    });

    //Get data from db
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      //Get main zones from db
      mainZoneList = await handler.getMainZones();
      buildMainZones();

      //Get all zones from db
      zoneList = await handler.getZones();
      buildZones();

      //Refresh state
      setState(() {});
    });
  }

//Build main zones
  buildMainZones() {
    if (mainZoneList != []) {
      for (var zone in mainZoneList) {
        pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(lat.LatLng(item[1], item[0]));
        }
        zones.add(Polygon(
          color: Colors.orange.withOpacity(0.5),
          borderColor: Colors.orange.withOpacity(0.9),
          borderStrokeWidth: 3,
          points: pointsList,
        ));
      }

      //Update state
      setState(() {});
    }
  }

  //Build zones
  buildZones() {
    if (zoneList != []) {
      //define color
      var i = 3025;
      for (var zone in zoneList) {
        pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(lat.LatLng(item[1], item[0]));
        }

        zones.add(
          Polygon(
            color: Color(0xff123456 + i * 100).withOpacity(0.7),
            borderColor: Color(0xff123456 + i * 100).withOpacity(0.9),
            borderStrokeWidth: 3,
            points: pointsList,
          ),
        );

        //Change color
        i = i + 96052;

        //Update state
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (zones.isNotEmpty) {
      return FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: lat.LatLng(mainZonelat, mainZonelong), //
          minZoom: 18.0,
          maxZoom: 18.0,
          zoom: 18.0,
          plugins: <MapPlugin>[
            LocationPlugin(),
          ],
        ),
        layers: [
          PolygonLayerOptions(polygons: zones),
        ],
        children: <Widget>[
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
          ),
        ],
        nonRotatedLayers: <LayerOptions>[
          LocationOptions(
            location(),
            onLocationUpdate: (LatLngData? ld) {},
            onLocationRequested: (LatLngData? ld) {
              if (ld == null) {
                return;
              }
              //mapController.move(ld.location, 16.0); //Move to current location
            },
          ),
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  LocationButtonBuilder location() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return ValueListenableBuilder<LocationServiceStatus>(
        valueListenable: status,
        builder:
            (BuildContext context, LocationServiceStatus value, Widget? child) {
          return const Text('');
        },
      );
    };
  }
}
