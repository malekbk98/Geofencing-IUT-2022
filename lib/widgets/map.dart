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
  late List<lat.LatLng> mainPointsList = [];
  late List<lat.LatLng> pointsList = [];
  final MapController mapController = MapController();
  bool setMainZone = false;
  bool setZones = false;

  //Build main zone (terrain)
  buildMainZone() async {
    print('im called');
    //Run this single time (async makes * calls so you need to break those calls)
    if (setMainZone == false) {
      dbHelper.getMainZone().then((value) {
        //Execute after getMainZone finish loading (async)
        for (var item in value.coordonnees) {
          //Add to temp list of coord
          mainPointsList.add(lat.LatLng(item[1], item[0]));
        }

        allZones.add(Polygon(
          color: Colors.orange.withOpacity(0.2),
          borderColor: Colors.orange.withOpacity(0.5),
          borderStrokeWidth: 2,
          points: mainPointsList,
        ));

        //Refresh state
        setState(() {});
      });
    }
  }

  //Build all zones
  void buildZones() {
    if (setZones == false) {
      dbHelper.getZones().then((value) {
        setZones = true;
        var i = 3325;
        for (var zone in value) {
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

        //Refresh state
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //buildMainZone();
    buildZones();

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
