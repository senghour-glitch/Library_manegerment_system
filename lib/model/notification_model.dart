import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String message;
  final String time;
  final String category;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.isRead = false,
  });
}