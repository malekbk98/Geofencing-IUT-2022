import 'package:flutter/material.dart';

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
          colorFilter: const ColorFilter.mode(Color.fromRGBO(0, 0, 0, .5), BlendMode.dstATop),
          image: image,
          fit: BoxFit.fitHeight,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}