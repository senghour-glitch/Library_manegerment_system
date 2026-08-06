import 'package:flutter/material.dart';
import 'package:library_onlile/provider/loginscreen_provider.dart';
import 'package:library_onlile/provider/onboarding_provider.dart';
import 'package:library_onlile/provider/splash_provider.dart';
import 'package:library_onlile/wedgid_controller.dart/costom_buttom.dart';
import 'package:provider/provider.dart';
import 'package:library_onlile/provider/homescreen_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
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
      home: const CostomBottom(),
    );
  }
}
