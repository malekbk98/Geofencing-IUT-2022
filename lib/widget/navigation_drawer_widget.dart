import 'package:flutter/material.dart';
import 'package:geofencing/pages/setting.dart';
import 'package:geofencing/pages/spots.dart';
import 'package:geofencing/pages/zones.dart';

import '../main.dart';

class NavigationDrawerWidget extends StatelessWidget{
  final padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context){
    return Drawer(
        child: Material(
          color: Color.fromRGBO(34, 36, 43, 1.0),
          child: ListView(
            padding: padding,
            children: <Widget> [
              DrawerHeader(
                  child: new Image.asset("assets/logo.png"),
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text:'Accueil',
                icon: Icons.home,
                onClicked: ()=>selectedItem(context, 0)
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text:'Les Zones',
                icon: Icons.map,
                  onClicked: ()=>selectedItem(context, 1)
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text:'Les Bornes',
                icon: Icons.location_on,
                  onClicked: ()=>selectedItem(context, 2)
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text:'Paramètres',
                icon: Icons.settings,
                  onClicked: ()=>selectedItem(context, 3)
              ),
            ],
          ),
        )
    );
  }

  selectedItem(BuildContext context, int i) {
    switch (i){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Acceuil',),
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
    required String logo,}) => {
    InkWell(
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            Image.asset('assets/images/logo.png')
          ],
        ),
      ),
    )
  };
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}){
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: Color.fromRGBO(198, 120, 9, 1.0)),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}