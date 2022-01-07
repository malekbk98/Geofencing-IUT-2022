import 'package:flutter/material.dart';
import 'package:geofencing/widget/navigation_drawer_widget.dart';

class SpotsPage extends StatelessWidget{
  @override
  Widget build (BuildContext context) => Scaffold(
    endDrawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text('Les bornes'),
      centerTitle: true,
      backgroundColor: Color.fromRGBO(34, 36, 43, 1.0),
    ),
  );
}