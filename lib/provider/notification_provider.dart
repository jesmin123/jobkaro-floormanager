import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier{

  int _notificationPending;

  NotificationProvider(){
    initNotification();
    notificationPending = 0;
  }

  initNotification(){
    //TODO Implement logic here
  }

  int getNotificationPending() => _notificationPending;

  set notificationPending(int value) {
    _notificationPending = value;
    notifyListeners();
  }


}