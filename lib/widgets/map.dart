// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:http/http.dart' as http;

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Polygon> mainZone = [];
    late List<lat.LatLng> mainPointsList = [];
    late List<lat.LatLng> pointsList = [];

    //Fetch main zone
    void fetchMainZone() async {
      final response = await http.get(Uri.parse(
          'http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain'));

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)['data'][0]['coordonnees']
            ['coordinates'][0];

        for (var item in res) {
          mainPointsList.add(lat.LatLng(item[1], item[0]));
        }
      } else {
        throw Exception('Failed to load album');
      }
    }

    //Fetch all zones
    void fetchZones() async {
      final response = await http.get(
          Uri.parse('http://docketu.iutnc.univ-lorraine.fr:62000/items/zone'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        var i = 3326;
        for (var zone in data) {
          print(zone['coordonnees']);
          pointsList = [];
          for (var item in zone['coordonnees']['coordinates'][0]) {
            pointsList.add(lat.LatLng(item[1], item[0]));
          }
          mainZone.add(Polygon(
            color: Color(0xff123456 + i * 100).withOpacity(0.5),
            borderColor: Color(0xff123456 + i * 100).withOpacity(0.5),
            borderStrokeWidth: 3,
            points: pointsList,
          ));
          i = i + 999;
        }
      } else {
        throw Exception('Failed to load album');
      }
    }

    fetchMainZone();
    fetchZones();

    mainZone.add(Polygon(
      color: Colors.orange.withOpacity(0.2),
      borderColor: Colors.orange.withOpacity(0.5),
      borderStrokeWidth: 2,
      points: mainPointsList,
    ));

    return FlutterMap(
      options: MapOptions(
        center: lat.LatLng(48.63122, 6.107505966858279),
        minZoom: 17.0,
        zoom: 17.0,
      ),
      layers: [
        PolygonLayerOptions(polygons: mainZone),
      ],
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ),
      ],
    );
  }
}
