import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/models/Zone.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonePage extends StatelessWidget {
  const ZonePage(this.zone, {Key? key}) : super(key: key);
  final Zone zone;

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(zone.nom),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getTextData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        '${uriAssets}/${zone.image_header}',
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                    ),
                    Text(
                      zone.description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(198, 120, 9, 1.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Markdown(
                      physics: const NeverScrollableScrollPhysics(),
                      data: snapshot.data.toString(),
                      shrinkWrap: true,
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );

  Future<String> getTextData() async {
    var md = "";

    for (var a in await handler.getZoneArticles(zone.id)) {
      md += a.content;
    }

    return md;
  }
}
