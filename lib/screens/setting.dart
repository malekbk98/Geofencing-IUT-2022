import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Paramètres'),
          centerTitle: true,
        ),
      );
}
