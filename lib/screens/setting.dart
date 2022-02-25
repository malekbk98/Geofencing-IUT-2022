import 'package:flutter/material.dart';
import 'package:geofencing/widgets/navigation_drawer_widget.dart';
import 'package:geofencing/theme/app_theme.dart';

import 'package:geofencing/data/loadData.dart';

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
                      _notifications = value;
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
                    const Text('Dernière date de mises à jour : DD-MM-YYYY')
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
