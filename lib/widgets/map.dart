import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:geofencing/data/DBHelper.dart' as dbHelper;

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late List<Polygon> allZones = [];
  late List<Polygon> zones = [];
  late List<lat.LatLng> mainPointsList = [];
  late List<lat.LatLng> pointsList = [];
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    buildZones();
  }

  buildZones() {
    late Polygon mainZone;
    dbHelper.getZones().then((value) {
      if (value.isNotEmpty) {}
      var i = 3025;
      for (var zone in value) {
        pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(lat.LatLng(item[1], item[0]));
        }
        if (zone.type == "mainZone") {
          mainZone = Polygon(
            color: Colors.orange.withOpacity(0.5),
            borderColor: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 3,
            points: pointsList,
          );
        } else {
          zones.add(Polygon(
            color: Color(0xff123456 + i * 100).withOpacity(0.7),
            borderColor: Color(0xff123456 + i * 100).withOpacity(0.9),
            borderStrokeWidth: 3,
            points: pointsList,
          ));
        }
        i = i + 96052;
      }

      //Add main zone at the end
      zones.add(mainZone);
      setState(() {
        allZones = zones;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allZones.isNotEmpty) {
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
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
