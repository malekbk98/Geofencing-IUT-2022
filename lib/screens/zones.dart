import 'package:flutter/material.dart';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:geofencing/widgets/zone_card.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonesScreen extends StatefulWidget {
  const ZonesScreen({Key? key}) : super(key: key);

  @override
  State<ZonesScreen> createState() => _ZonesScreenState();
}

class _ZonesScreenState extends State<ZonesScreen> {
  late DatabaseHandler handler;
  late List<Zone> zones = [];

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      //Get all zones from db
      zones = await handler.getZones();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les zones'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: zones
                  .map(
                    (zone) => ZoneCard(zone),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
