
import 'package:flutter/material.dart';
import '../model/setting_model.dart';

class SettingProvider extends ChangeNotifier {
  final SettingModel _setting = SettingModel();

  bool get isDarkMode => _setting.isDarkMode;
  bool get notifications => _setting.notifications;
  String get language => _setting.language;

  void toggleDarkMode(bool value) {
    _setting.isDarkMode = value;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _setting.notifications = value;
    notifyListeners();
  }

  void changeLanguage(String value) {
    _setting.language = value;
    notifyListeners();
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: language,
                onChanged: (value) {
                  if (value != null) {
                    changeLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Khmer'),
                value: 'Khmer',
                groupValue: language,
                onChanged: (value) {
                  if (value != null) {
                    changeLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}