import 'package:flutter/material.dart';

class AppUser {
  final String id;
  final String fullName;
  final String studentId;
  final String email;

  AppUser({
    required this.id,
    required this.fullName,
    required this.studentId,
    required this.email,
  });
}

enum RegisterStatus { idle, loading, success, error }

class RegisterProvider extends ChangeNotifier {
  RegisterStatus _status = RegisterStatus.idle;
  String? _errorMessage;
  AppUser? _currentUser;

  RegisterStatus get status => _status;
  String? get errorMessage => _errorMessage;
  AppUser? get currentUser => _currentUser;
  bool get isLoading => _status == RegisterStatus.loading;

  Future<bool> register({
    required String fullName,
    required String studentId,
    required String email,
    required String password,
    required String confirmPassword,
    required bool agreedToTerms,
  }) async {
    _errorMessage = null;

    if (fullName.trim().isEmpty) {
      return _fail('Please enter your full name.');
    }
    if (studentId.trim().isEmpty) {
      return _fail('Please enter your student ID.');
    }
    if (!_isValidEmail(email)) {
      return _fail('Please enter a valid email address.');
    }
    if (password.length < 6) {
      return _fail('Password must be at least 6 characters.');
    }
    if (password != confirmPassword) {
      return _fail('Passwords do not match.');
    }
    if (!agreedToTerms) {
      return _fail('Please agree to the Terms of Service to continue.');
    }


    _status = RegisterStatus.loading;
    notifyListeners();

    try {
   
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = AppUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: fullName.trim(),
        studentId: studentId.trim(),
        email: email.trim(),
      );
      _status = RegisterStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      return _fail('Something went wrong. Please try again.');
    }
  }

  void reset() {
    _status = RegisterStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  bool _fail(String message) {
    _errorMessage = message;
    _status = RegisterStatus.error;
    notifyListeners();
    return false;
  }

  bool _isValidEmail(String value) {
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\-\.]+$');
    return regex.hasMatch(value.trim());
  }
  
}