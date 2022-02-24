import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:geofencing/theme/app_theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notifications = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Paramètres'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  secondary: _notifications
                      ? const Icon(Icons.notifications_active)
                      : const Icon(Icons.notifications_off),
                  title: Text(
                    'Enable/disbale notifications',
                    style: TextStyle(
                      color: AppTheme.mainColor,
                    ),
                  ),
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
