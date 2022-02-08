import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class Borne extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Les bornes'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 39, 40, 43),
        ),
        body: 
        Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 78, 81, 92)),
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
              Expanded(
                child: FutureBuilder(
                  future: getTextData(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Markdown(
                        data: snapshot.data.toString(),
                        styleSheet: MarkdownStyleSheet.fromTheme(
                          ThemeData(
                            textTheme: const TextTheme(
                                headline6: TextStyle(fontSize: 20.0,color: Colors.yellow),
                                headline5: TextStyle(fontSize: 20.0,color: Colors.yellow),
                                bodyText2: TextStyle(fontSize: 16.0,color: Colors.white)
                              )
                            )
                          ),
                      );
                    }
                    return Container();
                  }
                ),
              ),
            ],    
          ),
        ),
      );

  Future<String> getTextData() async{
    String url = 'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    var response = await http.get(Uri.parse(url));
    return response.body;
  }
}
