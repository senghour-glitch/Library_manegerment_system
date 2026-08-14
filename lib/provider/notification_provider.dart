import 'package:flutter/material.dart';
import 'package:library_onlile/model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Academic',
    'Reminders',
    'New Arrivals',
  ];

  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Borrow Successful',
      message:
          '“The Structure of Scientific Revolutions” has been added to your active shelf. Enjoy your reading!',
      time: '10:45 AM',
      category: 'Academic',
      icon: Icons.check_circle,
      iconColor: Colors.white,
      iconBackground: Color(0xFF0B6077),
      isRead: false,
    ),

    NotificationModel(
      title: 'Due Reminder',
      message:
          'The “Republic” is due in 48 hours. Please visit the library or extend your borrow period online.',
      time: '09:15 AM',
      category: 'Reminders',
      icon: Icons.access_time,
      iconColor: Color(0xFF8C7800),
      iconBackground: Color(0xFFFFF5C7),
      isRead: false,
    ),

    NotificationModel(
      title: 'New Books Added',
      message:
          '12 new titles added to the “Classical History” section. Explore the latest additions to our archive.',
      time: 'Yesterday, 4:30 PM',
      category: 'New Arrivals',
      icon: Icons.library_books,
      iconColor: Color(0xFF555555),
      iconBackground: Color(0xFFEDEDED),
      isRead: true,
    ),

    NotificationModel(
      title: 'Reading Milestone',
      message:
          'Congratulations! You’ve reached your reading goal of 500 pages this month.',
      time: 'Yesterday, 11:00 AM',
      category: 'Academic',
      icon: Icons.workspace_premium,
      iconColor: Color(0xFF0B6077),
      iconBackground: Color(0xFFE4F3F7),
      isRead: true,
    ),

    NotificationModel(
      title: 'Security Alert',
      message:
          'New login detected from a Chrome browser on Windows. If this wasn’t you, please reset your password.',
      time: 'Oct 24, 2023',
      category: 'Academic',
      icon: Icons.security,
      iconColor: Colors.red,
      iconBackground: Color(0xFFFFE5E5),
      isRead: true,
    ),
  ];

  List<NotificationModel> get notifications {
    if (selectedCategory == 'All') {
      return _notifications;
    }

    return _notifications
        .where((notification) =>
            notification.category == selectedCategory)
        .toList();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      // Model is immutable, so replace the item.
      final old = _notifications[index];

      _notifications[index] = NotificationModel(
        title: old.title,
        message: old.message,
        time: old.time,
        category: old.category,
        icon: old.icon,
        iconColor: old.iconColor,
        iconBackground: old.iconBackground,
        isRead: true,
      );

      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      final old = _notifications[i];

      _notifications[i] = NotificationModel(
        title: old.title,
        message: old.message,
        time: old.time,
        category: old.category,
        icon: old.icon,
        iconColor: old.iconColor,
        iconBackground: old.iconBackground,
        isRead: true,
      );
    }

    notifyListeners();
  }
}