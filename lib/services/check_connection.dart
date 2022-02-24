import 'dart:async';
import 'package:geofencing/errors/error_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final Connectivity _connectivity = Connectivity();
late StreamSubscription<ConnectivityResult> subscription;

class CheckConnection {
  //Check internet connection
  static bool initializeCheck() {
    bool _isOnline = false;
    late String connectionType;

    subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult res) {
      connectionType = res.name;
      if (connectionType == 'none') {
        throw ErrorHandler('There is no internet connection');
      }
    });

    return _isOnline;
  }
}
