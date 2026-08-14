import 'package:flutter/material.dart';
import 'package:library_onlile/model/notification_model.dart';
import 'package:library_onlile/provider/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF07546B),
            size: 20,
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF07546B),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF07546B),
            ),
            onSelected: (value) {
              if (value == 'read') {
                provider.markAllAsRead();
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 'read',
                  child: Text('Mark all as read'),
                ),
              ];
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Categories
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = provider.categories[index];

                  final isSelected =
                      provider.selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      provider.selectCategory(category);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF07546B)
                            : const Color(0xFFF1F3F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF666666),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: provider.notifications.isEmpty
                ? const Center(
                    child: Text(
                      'No notifications',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                    children: [
                      _sectionTitle('TODAY'),

                      const SizedBox(height: 7),

                      ...provider.notifications
                          .where(
                            (item) =>
                                item.time.contains('AM') ||
                                item.time.contains('PM'),
                          )
                          .map(
                            (notification) => _NotificationCard(
                              notification: notification,
                            ),
                          ),

                      const SizedBox(height: 18),

                      _sectionTitle('YESTERDAY'),

                      const SizedBox(height: 7),

                      ...provider.notifications
                          .where(
                            (item) =>
                                item.time.contains('Yesterday'),
                          )
                          .map(
                            (notification) => _NotificationCard(
                              notification: notification,
                            ),
                          ),

                      const SizedBox(height: 18),

                      _sectionTitle('EARLIER THIS WEEK'),

                      const SizedBox(height: 7),

                      ...provider.notifications
                          .where(
                            (item) =>
                                !item.time.contains('AM') &&
                                !item.time.contains('PM') &&
                                !item.time.contains('Yesterday'),
                          )
                          .map(
                            (notification) => _NotificationCard(
                              notification: notification,
                            ),
                          ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        color: Color(0xFF777777),
        letterSpacing: 0.8,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationCard({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final provider = context.read<NotificationProvider>();

        final index = provider.notifications.indexOf(notification);

        if (index != -1) {
          provider.markAsRead(index);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: notification.iconBackground,
              width: 2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: notification.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification.icon,
                size: 15,
                color: notification.iconColor,
              ),
            ),

            const SizedBox(width: 10),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF27323A),
                          ),
                        ),
                      ),

                      if (!notification.isRead)
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF07546B),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 9.5,
                      height: 1.45,
                      color: Color(0xFF666666),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    notification.time,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}