import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/splash_provider.dart';
import 'provider/onboarding_provider.dart';

import 'view/splash_screen.dart';

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
        // ChangeNotifierProvider(
        //   create: (_) => SettingProvider(),
        // ),
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
      home: const SplashScreen(),
    );
  }
}