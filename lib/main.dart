import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geofencing/theme/app_theme.dart';

import 'MyHomePage.dart';

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
    return MaterialApp(
      title: 'Geofencing',
      theme: AppTheme.theme,
      home: const MyHomePage(title: 'Accueil'),
      debugShowCheckedModeBanner: false,
    );
  }
}
