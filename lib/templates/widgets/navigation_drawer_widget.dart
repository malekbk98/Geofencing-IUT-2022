import 'package:flutter/material.dart';
import 'package:geofencing/screens/setting_page.dart';
import 'package:geofencing/screens/spots_page.dart';
import 'package:geofencing/screens/zones_page.dart';
import 'package:geofencing/theme/app_theme.dart';

import '../main.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Color.fromRGBO(34, 36, 43, 1.0),
      child: ListView(
        padding: padding,
        children: <Widget>[
          DrawerHeader(
            child: new Image.asset("assets/logo.png"),
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
          builder: (context) => MyHomePage(
            title: 'Acceuil',
          ),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ZonesPage(),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpotsPage(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingPage(),
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
  return ListTile(
    leading: Icon(icon, color: AppTheme.mainColor),
    title: Text(text),
    onTap: onClicked,
  );
}
