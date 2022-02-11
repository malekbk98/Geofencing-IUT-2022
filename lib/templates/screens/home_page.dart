import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HomePage extends StatelessWidget {
  final String md;
  final Widget map;

  const HomePage(this.md, this.map, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: <Widget>[
          Card(
            child: map
          ),
          Markdown(
            physics: const NeverScrollableScrollPhysics(),
            data: md,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }
}