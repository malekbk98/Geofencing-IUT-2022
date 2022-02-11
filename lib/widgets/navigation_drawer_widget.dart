import 'package:flutter/material.dart';
import 'package:geofencing/screens/setting.dart';
import 'package:geofencing/screens/spots.dart';
import 'package:geofencing/screens/zones.dart';

import '../main.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 10);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: const Color.fromRGBO(34, 36, 43, 1.0),
      child: ListView(
        padding: padding,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset("assets/logo.png"),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
              text: 'Accueil',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0)),
          const SizedBox(height: 16),
          buildMenuItem(
              text: 'Les Zones',
              icon: Icons.map,
              onClicked: () => selectedItem(context, 1)),
          const SizedBox(height: 16),
          buildMenuItem(
              text: 'Les Bornes',
              icon: Icons.location_on,
              onClicked: () => selectedItem(context, 2)),
          const SizedBox(height: 16),
          buildMenuItem(
              text: 'Paramètres',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 3)),
        ],
      ),
    ));
  }

  selectedItem(BuildContext context, int i) {
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: 'Acceuil',
          ),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ZonesScreen(),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpotsScreen(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingScreen(),
        ));
    }
  }

  buildHeader({
    required String logo,
  }) =>
      {
        InkWell(
          child: Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [Image.asset('assets/images/logo.png')],
            ),
          ),
        )
      };
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: const Color.fromRGBO(198, 120, 9, 1.0)),
    title: Text(text, style: const TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
