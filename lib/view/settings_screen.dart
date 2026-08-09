import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/setting_provider.dart';
import 'notification_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<SettingProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'General',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Column(
                  children: [
                    // Language
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.language),
                      ),
                      title: const Text('Language'),
                      subtitle: Text(provider.language),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        provider.showLanguageDialog(context);
                      },
                    ),

                    const Divider(height: 1),

                    // Dark Mode
                    SwitchListTile(
                      secondary: const CircleAvatar(
                        child: Icon(Icons.dark_mode),
                      ),
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Enable dark theme'),
                      value: provider.isDarkMode,
                      onChanged: (value) {
                        provider.toggleDarkMode(value);
                      },
                    ),

                    const Divider(height: 1),

                    // Notifications
                    SwitchListTile(
                      secondary: const CircleAvatar(
                        child: Icon(Icons.notifications),
                      ),
                      title: const Text('Notifications'),
                      subtitle: const Text(
                        'Receive notification messages',
                      ),
                      value: provider.notifications,
                      onChanged: (value) {
                        provider.toggleNotifications(value);
                      },
                    ),

                    const Divider(height: 1),

                    // Open Notification Screen
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.notifications_active),
                      ),
                      title: const Text('Notification Center'),
                      subtitle: const Text(
                        'View all notifications',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: const Text('Profile'),
                      subtitle: const Text(
                        'View your profile',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.lock),
                      ),
                      title: const Text('Privacy'),
                      subtitle: const Text(
                        'Privacy and security',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'About',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.info),
                  ),
                  title: const Text('About Library App'),
                  subtitle: const Text(
                    'Library Management System',
                  ),
                  trailing: const Text('v1.0.0'),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  'Library App © 2026',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
