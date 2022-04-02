import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/models/Spot.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class SpotPage extends StatelessWidget {
  String id;
  String md = " ";

  SpotPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getSpotData(),
            builder: (context, AsyncSnapshot<Spot> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          '${uriAssets}/${snapshot.data!.image_header}',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                      ),
                      Text(
                        snapshot.data!.description,
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
                        data: md,
                        shrinkWrap: true,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );

  Future<Spot> getSpotData() async {
    //Get sopt from db
    Spot spot = await DatabaseHandler().getSpot(id);

    //Get spot articles
    var articles = await handler.getSpotArticle(spot.id.toString());
    String temp = " ";

    //Combine articles
    for (var a in articles) {
      print(a);
      temp = temp + a.content;
    }

    md = temp;
    return spot;
  }
}
