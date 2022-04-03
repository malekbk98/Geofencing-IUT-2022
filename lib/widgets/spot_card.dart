import 'package:flutter/material.dart';
import 'package:geofencing/screens/spot_page.dart';
import 'package:geofencing/theme/app_theme.dart';

class SpotCard extends StatelessWidget {
  final String id;
  final String title;
  final ImageProvider image;

  const SpotCard(this.id, this.title, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SpotPage(id)));
      },
      child: Container(
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(AppTheme.fadedBackground, BlendMode.dstATop),
            image: image,
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
