import 'package:flutter/material.dart';
import 'package:geofencing/screens/home_page.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geofencing',
      theme: AppTheme.theme,
      home: const MyHomePage(title: 'Accueil'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Acceuill'),
      ),
      body: FutureBuilder(
        future: getTextData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return HomePage(
              snapshot.data.toString(), 
              Image.network(
              'https://placeimg.com/640/480/any',
              fit: BoxFit.fill,
            ),);
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  Future<String> getTextData() async{
    String url = 'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    var response = await http.get(url);
    return response.body;
  }
}