// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:http/http.dart' as http;

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Polygon> points;
    late Zone mainZone;
    late List<lat.LatLng> pointsList = [];

    Future<Zone> fetchZone() async {
      final response = await http.get(Uri.parse(
          'http://docketu.iutnc.univ-lorraine.fr:62000/items/terrain'));

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)['data'][0]['coordonnees']
            ['coordinates'][0];

        for (var item in res) {
          pointsList.add(lat.LatLng(item[1], item[0]));
        }
        return Zone.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load album');
      }
    }

    fetchZone();

    points = [
      Polygon(
        color: Colors.yellow.withOpacity(0.5),
        borderColor: Colors.blue,
        points: pointsList,
      )
    ];

    return FlutterMap(
      options: MapOptions(
        center: lat.LatLng(48.63122, 6.107505966858279),
        zoom: 17.0,
      ),
      layers: [
        PolygonLayerOptions(
          polygons: points,
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: lat.LatLng(48.63180334364356, 6.10944),
              builder: (ctx) => Container(),
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayerWidget(
            options: TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'])),
        MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: [
              Marker(
                width: 100.0,
                height: 100.0,
                point: lat.LatLng(48.63180334364356, 6.107505966858279),
                builder: (ctx) => Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
