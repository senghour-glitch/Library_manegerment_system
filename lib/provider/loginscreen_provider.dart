import 'package:flutter/material.dart';
import 'package:library_onlile/wedgid_controller.dart/costom_buttom.dart';

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
    final String email =
        emailController.text.trim();

    final String password =
        passwordController.text.trim();

 
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all fields',
          ),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Login Success',
        ),
      ),
    );

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(
        builder: (_) =>CostomButtom(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}