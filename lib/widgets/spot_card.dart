import 'package:flutter/material.dart';
import 'package:geofencing/theme/app_theme.dart';

class SpotCard extends StatelessWidget {
  final String title;
  final ImageProvider image;

  const SpotCard(this.title, this.image, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(AppTheme.fadedBackground, BlendMode.dstATop),
          image: image,
          fit: BoxFit.fitHeight,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}