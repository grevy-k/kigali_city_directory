import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const _key = 'location_notifications';

  bool locationNotifications = true;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    locationNotifications = sp.getBool(_key) ?? true;
    notifyListeners();
  }

  Future<void> setLocationNotifications(bool value) async {
    locationNotifications = value;
    notifyListeners();
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_key, value);
  }
}