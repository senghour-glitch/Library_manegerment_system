import 'package:flutter/material.dart';
import 'package:library_onlile/view/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }
  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
  void login(BuildContext context) {
    if(emailController.text.isEmpty ||
       passwordController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Success"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
