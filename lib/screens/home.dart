import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/widgets/map.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 78, 81, 92)),
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: const SizedBox(
                  height: 300,
                  child: MapWidget(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(10),
              ),
              // Expanded(
              //   child: FutureBuilder(
              //     future: getTextData(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Markdown(
              //           data: snapshot.data.toString(),
              //           styleSheet: MarkdownStyleSheet.fromTheme(
              //             ThemeData(
              //               textTheme: const TextTheme(
              //                 headline6: TextStyle(
              //                     fontSize: 20.0, color: Colors.orange),
              //                 headline5: TextStyle(
              //                     fontSize: 20.0, color: Colors.orange),
              //                 bodyText2: TextStyle(
              //                     fontSize: 16.0, color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         );
              //       }
              //       return Container();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(34, 36, 43, 1.0),
          child: const Icon(Icons.qr_code),
          onPressed: () {},
        ),
      );
  Future<String> getTextData() async {
    String url =
        'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    var response = await http.get(Uri.parse(url));
    return response.body;
  }
}
