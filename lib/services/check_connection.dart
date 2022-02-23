import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final Connectivity _connectivity = Connectivity();
late StreamSubscription<ConnectivityResult> subscription;

class CheckConnection {
  //Check internet connection
  static bool initializeCheck() {
    bool _isOnline = false;

    subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult res) {
      print(res.name);
      if (res.name == "wifi" || res.name == "mobile") {
        _isOnline = true;
      }
    });

    return _isOnline;
  }
}
