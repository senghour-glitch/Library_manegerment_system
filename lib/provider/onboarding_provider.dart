import 'package:flutter/material.dart';
import 'package:library_onlile/model/onboarding_model.dart';
import 'package:library_onlile/view/login_screen.dart';
import 'package:library_onlile/view/register_screen.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  int currentPage = 0;
  final List<OnboardingModel> pages = [
    OnboardingModel(
      image:
          "https://i.pinimg.com/1200x/dd/b9/c1/ddb9c1dcfc4f774a73783b4474b1faa0.jpg",
      title: "Welcome",
      description: "Welcome to our Library App.",
    ),
    OnboardingModel(
      image:
          "https://i.pinimg.com/736x/ec/2d/5c/ec2d5ccf98aa8a90d27a74431521069b.jpg",
      title: "Discover",
      description: "Find your favorite books easily.",
    ),
    OnboardingModel(
      image:
          "https://i.pinimg.com/1200x/c5/8f/4b/c58f4bb252ef51911da5c2c1a6bee0e2.jpg",
      title: "Borrow",
      description: "Borrow and return books anytime.",
    ),
  ];
  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => RegisterScreen()),
      );
    }
  }

  void skip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
