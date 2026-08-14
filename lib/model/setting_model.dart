class SettingModel {
  bool isDarkMode;
  bool notifications;
  String language;

  SettingModel({
    this.isDarkMode = false,
    this.notifications = true,
    this.language = 'English',
  });
}
