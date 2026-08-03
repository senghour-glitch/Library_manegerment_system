import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {

  bool isDarkMode = false;
  bool notification = true;

  void changeDarkMode(bool value){
    isDarkMode = value;
    notifyListeners();
  }

  void changeNotification(bool value){
    notification = value;
    notifyListeners();
  }
}