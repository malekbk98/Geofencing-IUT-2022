import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class ZonePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          centerTitle: true,
        ),
        body: 
        FutureBuilder(
          future: getTextData(),
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
                          'https://placeimg.com/640/480/any',
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
                        data: snapshot.data.toString(),
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

  Future<String> getTextData() async{
    String url = 'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    var response = await http.get(url);
    return response.body;
  }
}
