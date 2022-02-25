import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/models/Spot.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class SpotPage extends StatelessWidget {
  String id;
  late Spot spot;
  late String md;
  
  SpotPage(this.id, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          centerTitle: true,
        ),
        body: 
        FutureBuilder(
          future: getSpotData(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          '${uriAssets}/${spot.image_header}',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                      ),
                      Markdown(
                        physics: const NeverScrollableScrollPhysics(),
                        data: spot.description,
                        shrinkWrap: true,
                      )
                    ],
                  ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      );

  Future<Spot> getSpotData() async{
    spot = await DatabaseHandler().getSpot(id);

    var articles = await handler.getZoneArticles(spot.id);
        
    for (var a in articles) {
      md += a.content;
    }

    return spot;
  }
}
