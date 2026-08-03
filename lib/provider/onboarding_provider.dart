
import 'package:flutter/material.dart';
import 'package:library_onlile/model/onboarding_model.dart';
import 'package:library_onlile/view/login_screen.dart';
class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  int currentPage = 0;
  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: "assets/images/library.png",
      title: "Welcome",
      description: "Welcome to our Library App.",
    ),
    OnboardingModel(
      image: "assets/images/book.png",
      title: "Discover",
      description: "Find your favorite books easily.",
    ),
    OnboardingModel(
      image: "assets/images/borrow.png",
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
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    }
  }
  void skip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}