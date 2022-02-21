import 'package:flutter/material.dart';
import 'package:geofencing/widgets/spot_card.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class SpotsScreen extends StatelessWidget {
  const SpotsScreen({Key? key}) : super(key: key);

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
        children: const <Widget>[
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
          SpotCard("Spot1", NetworkImage('https://placeimg.com/640/480/any')),
        ]
      ),
  );
}
