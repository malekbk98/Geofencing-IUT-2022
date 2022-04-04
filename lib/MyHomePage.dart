import 'package:flutter/material.dart';
import 'package:geofencing/data/DatabaseHandler.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:geofencing/screens/home.dart';
import 'package:geofencing/services/check_connection.dart';
import 'package:geofencing/services/qr_service.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool connectionStatus = false;
  bool dbCheck = false;
  bool isInit = true;

  @override
  void initState() {
    if (isInit == false) {
      super.initState();
      isInit = true;
    }

    //Check internet connection
    CheckConnection.initializeCheck().then((status) {
      setState(() {
        connectionStatus = status;
      });
    });

    //Check if db contain data or not
    handler = DatabaseHandler();
    handler.dbIsEmptyOrNot().then((res) {
      setState(() {
        dbCheck = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dbCheck == false || connectionStatus == true) {
      //Proceed running the app (There's internet connection OR database already have data [can work offline])
      return Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color.fromRGBO(34, 36, 43, 1.0),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: initData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const HomeScreen();
              }
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.mainColor,
            child: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QrService(),
              ));
            }),
      );
    } else {
      //No internet connection found and the database is empty
      return AlertDialog(
        title: const Text("Internet requis"),
        content: const Text(
            "Ops, vous avez besoin d'une connexion Internet pour ouvrir l'application"),
        actions: [
          TextButton(
            child: const Text(
              "Réessayer",
              style: TextStyle(
                color: Color.fromRGBO(198, 120, 9, 1.0),
              ),
            ),
            onPressed: () {
              initState();
            },
          ),
        ],
      );
    }
  }
}
