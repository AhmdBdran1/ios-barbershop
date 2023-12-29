import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;


class AppStateManager with ChangeNotifier {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int _selectedIndex = 0;
  int _selectedDateIndex=0;
  String _selectedDate='';

  int get selectedIndex => _selectedIndex;
  int get selectedDateIndex=>_selectedDateIndex;
  String get selectedDate=>_selectedDate;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  set selectedDatesIndex(int index) {
    _selectedDateIndex= index;
    notifyListeners();
  }

  set selectedDate(String date){

    _selectedDate=date;
    notifyListeners();
  }

  AppStateManager() {
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Replace with your launcher icon name
    const ios=DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: ios,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('finish to initialization');

    notifyListeners();
  }

}
