import 'package:flutter/material.dart';
import 'package:library_onlile/provider/loginscreen_provider.dart';
import 'package:library_onlile/provider/notification_provider.dart';
import 'package:library_onlile/provider/onboarding_provider.dart';
import 'package:library_onlile/provider/profile_provider.dart';
import 'package:library_onlile/provider/register_provider.dart';
import 'package:library_onlile/provider/setting_provider.dart';
import 'package:library_onlile/provider/splash_provider.dart';
import 'package:library_onlile/provider/homescreen_provider.dart';
import 'package:library_onlile/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library',
      home: const SplashScreen(),
    );
  }
}