import 'dart:async';
import 'package:flutter/material.dart';
import 'package:library_onlile/view/onboarding_screen.dart';

class SplashProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void startSplash(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      _isLoading = false;
      notifyListeners();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }
}