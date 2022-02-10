import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/screens/home.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:geofencing/data/DBHelper.dart' as dbHelper;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      title: 'Geofencing',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Accueil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color.fromRGBO(34, 36, 43, 1.0),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: dbHelper.getMainZone(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                print(snapshot.data);

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const HomeScreen();
            }));
  }
}
