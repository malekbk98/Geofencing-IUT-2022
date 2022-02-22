import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geofencing/widgets/map.dart';
import 'package:http/http.dart' as http;
import 'package:poly_geofence_service/models/poly_geofence.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';

import '../data/DatabaseHandler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _streamController = StreamController<PolyGeofence>();
  late DatabaseHandler handler;
  late List<PolyGeofence> zonesList = [];

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 5000,
      accuracy: 1000,
      loiteringDelayMs: 500,
      statusChangeDelayMs: 500,
      allowMockLocations: true,
      printDevLog: true);

  // Create a [PolyGeofence] list.
  final _polyGeofenceList = <PolyGeofence>[
    PolyGeofence(
      id: 'Zone 1',
      data: {
        'address': 'Crous ',
        'about': 'Bla Bla Bla',
      },
      polygon: <LatLng>[
        const LatLng(48.67029151791478, 6.173656270868103),
        const LatLng(48.66668263296904, 6.167781150638174),
        const LatLng(48.66466825506998, 6.174519819218139),
        const LatLng(48.66836783548197, 6.1781724272606295),
        const LatLng(48.67029151791478, 6.173656270868103),
      ],
    ),
  ];

  // This function is to be called when the geofence status is changed.
  Future<void> _onPolyGeofenceStatusChanged(PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus, Location location) async {
    //print('polyGeofence: ${polyGeofence.toJson()}');
    print('polyGeofenceStatus: ${polyGeofenceStatus.toString()}');
    _streamController.sink.add(polyGeofence);
  }

  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    print('location: ${location.toJson()}');
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      //Get all zones from db
      var temp = await handler.getZones();
      for (var zone in temp) {
        late List<LatLng> pointsList = [];
        for (var item in zone.coordonnees) {
          pointsList.add(LatLng(item[1], item[0]));
        }

        zonesList.add(
          PolyGeofence(
            id: zone.id.toString(),
            data: {
              'name': zone.nom,
              'description': zone.description,
            },
            polygon: pointsList,
          ),
        );
        //Update state
        setState(() {});
      }
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _polyGeofenceService
            .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
        _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
        _polyGeofenceService.addLocationServicesStatusChangeListener(
            _onLocationServicesStatusChanged);
        _polyGeofenceService.addStreamErrorListener(_onError);
        _polyGeofenceService.start(zonesList).catchError(_onError);
      });
    });
  }

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

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
