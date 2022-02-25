import 'package:flutter/material.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:geofencing/screens/zone_page.dart';

class ZoneCard extends StatelessWidget {
  final String title;
  final ImageProvider image;

  const ZoneCard(this.title, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print("zone");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ZonePage()));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(AppTheme.fadedBackground, BlendMode.dstATop),
            image: image,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
