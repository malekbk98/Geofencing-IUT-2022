import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  setNotificationsPreferences(bool status) async {
    // on récupère les préférences du client
    final prefs = await SharedPreferences.getInstance();

    // configuration du booleen 'notifications' à true or false (default: false)
    return await prefs.setBool('notifications', status);
  }

  Future<bool?> getNotificationsPreferences(String prefName) async {
    // on récupère les préférences du client
    final prefs = await SharedPreferences.getInstance();

    //on récupère la préférence 'notifications'
    final bool? notificationsStatus = prefs.getBool(prefName);

    //la méthode retourne l'état de cette préférence
    return notificationsStatus;
  }
}
