import 'package:flutter/material.dart';
import 'package:geofencing/components/zone_card.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonesPage extends StatelessWidget {
  const ZonesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les zones'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                  ZoneCard('Zone1', NetworkImage('https://placeimg.com/640/480/any')),
                ],
              ),
            ),
          ),
      );
}
