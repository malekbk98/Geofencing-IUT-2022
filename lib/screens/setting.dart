import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:geofencing/services/user_preferences.dart';
import 'package:geofencing/data/loadData.dart';
import 'package:vibration/vibration.dart';
import 'package:geofencing/data/DatabaseHandler.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late bool _notifications = true;
  late String dateUpdate;

  @override
  void initState() {
    super.initState();

    handler.initializeDB().whenComplete(() async {
      await handler.getDateTimeOfLastIdUpdate().then((value) {
        setState(() {
          dateUpdate = value;
        });
      });
    });

    //get the notification preference, then
    UserPreferences()
        .getNotificationsPreferences('notifications')
        .then((value) {
      //Change state
      setState(() {
        _notifications = value!;
      });
    });
  }

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
                Image.asset(
                  'assets/logo.png',
                  scale: 3,
                ),
                SwitchListTile(
                  secondary: _notifications
                      ? const Icon(Icons.notifications_active)
                      : const Icon(Icons.notifications_off),
                  title: Text(
                    'Activez/désactiver les notifications',
                    style: TextStyle(
                      color: AppTheme.mainColor,
                    ),
                  ),
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      UserPreferences().setNotificationsPreferences(value);
                      _notifications = value;
                      if (_notifications) {
                        Vibration.vibrate(duration: 400);
                      }
                    });
                  },
                ),
                Column(
                  children: [
                    ElevatedButton.icon(
                      label: const Text('Vérifiez les mises à jour'),
                      icon: const Icon(Icons.update),
                      onPressed: () async {
                        bool updateCheck = await fetchIdUpdate();
                        if (updateCheck) {
                          initData();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Mises à jour des données terminée"),
                          ));
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Aucune mises à jour est disponible"),
                        ));
                      },
                      style:
                          ElevatedButton.styleFrom(primary: AppTheme.mainColor),
                    ),
                    const Text('Dernière date de mises à jour :'),
                    Text(dateUpdate),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
