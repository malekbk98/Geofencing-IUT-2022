import 'package:flutter/material.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:geofencing/screens/zone_page.dart';

class ZoneCard extends StatelessWidget {
  final Zone zone;

  const ZoneCard(this.zone, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ZonePage(zone)));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            zone.nom,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(AppTheme.fadedBackground, BlendMode.dstATop),
            image: NetworkImage('$uriAssets/${zone.image_header}'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
