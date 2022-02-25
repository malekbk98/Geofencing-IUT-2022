import 'package:flutter/material.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/models/Spot.dart';
import 'package:geofencing/widgets/spot_card.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

import '../data/DatabaseHandler.dart';

class SpotsScreen extends StatefulWidget {
  const SpotsScreen({ Key? key }) : super(key: key);

  @override
  _SpotsScreenState createState() => _SpotsScreenState();
}

class _SpotsScreenState extends State<SpotsScreen> {
  late DatabaseHandler handler;
  late List<Spot> spots;
  

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      //Get all zones from db
      spots = await handler.getSpots();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    endDrawer: const NavigationDrawerWidget(),
    appBar: AppBar(
      title: const Text('Les bornes'),
      centerTitle: true,
    ),
    body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: spots
                  .map((spot) => SpotCard(
                      spot.id.toString(),
                      spot.name,
                      NetworkImage('${uriAssets}/${spot.image_header}')))
                  .toList()
      ),
  );
}