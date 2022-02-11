import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Paramètres'),
          centerTitle: true,
        ),
      );
}
