import 'package:flutter/material.dart';
import 'package:library_onlile/view/onboarding_screen.dart';

class SplashProvider extends ChangeNotifier {
  bool isLoading = true;

  void startSplash(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (!context.mounted) return;

      isLoading = false;
      notifyListeners();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }
}