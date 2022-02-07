import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Les zones'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(34, 36, 43, 1.0),
        ),
      );
}
