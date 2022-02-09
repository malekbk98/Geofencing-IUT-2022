// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:geofencing/data/loadData.dart' as data;
import 'package:geofencing/models/Zone.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:geofencing/data/DBHelper.dart' as dbHelper;

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final List<Polygon> allZones = [];
  late List<lat.LatLng> mainPointsList = [];
  late List<lat.LatLng> pointsList = [];

  final MapController mapController = MapController();

  //Build main zone (terrain)
  buildMainZone() async {
    final LocalStorage storage = new LocalStorage('geofencing');
    Zone mainZone = dbHelper.getMainZone() as Zone;
    print("mainZone");
    if (0 == 0) {
      for (var item in mainZone.coordonnees) {
        mainPointsList.add(lat.LatLng(item[1], item[0]));
      }
    } else {
      throw Exception('Failed to build main zone');
    }
  }

  //Build all zones
  void buildZones() {
    final LocalStorage storage = new LocalStorage('geofencing');
    List<Zone> zones = storage.getItem('zones');
    if (zones is List<Zone>) {
      var i = 3326;
      for (var zone in zones) {
        pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(lat.LatLng(item[1], item[0]));
        }
        allZones.add(Polygon(
          color: Color(0xff123456 + i * 100).withOpacity(0.5),
          borderColor: Color(0xff123456 + i * 100).withOpacity(0.5),
          borderStrokeWidth: 3,
          points: pointsList,
        ));
        i = i + 999;
      }
    } else {
      throw Exception('Failed to build all zones');
    }
  }

  @override
  Widget build(BuildContext context) {
    buildMainZone();
    //buildZones();

    allZones.add(Polygon(
      color: Colors.orange.withOpacity(0.2),
      borderColor: Colors.orange.withOpacity(0.5),
      borderStrokeWidth: 2,
      points: mainPointsList,
    ));

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: lat.LatLng(48.63122, 6.107505966858279),
        minZoom: 18.0,
        maxZoom: 18.0,
        zoom: 18.0,
        plugins: <MapPlugin>[
          // USAGE NOTE 2: Add the plugin
          LocationPlugin(),
        ],
      ),
      layers: [
        PolygonLayerOptions(polygons: allZones),
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
        // USAGE NOTE 3: Add the options for the plugin
        LocationOptions(
          locationButton(),
          onLocationUpdate: (LatLngData? ld) {
            //print('Location updated: ${ld?.location} (accuracy: ${ld?.accuracy})');
          },
          onLocationRequested: (LatLngData? ld) {
            if (ld == null) {
              return;
            }
            //mapController.move(ld.location, 16.0); Move to current location
          },
        ),
      ],
    );
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
