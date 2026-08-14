import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:library_onlile/provider/register_provider.dart';
import 'package:library_onlile/view/login_screen.dart';
import 'package:library_onlile/wedgid_controller.dart/costom_buttom.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class AppColors {
  // static const background = Color(0xFFF6C9C9); 
  static const scaffold = Color(0xFFF3F1EC);
  static const fieldFill = Colors.white;
  static const fieldBorder = Color(0xFFD9DEE7);
  static const primary = Color(0xFF1B4B5A); 
  static const textDark = Color(0xFF1B2A33);
  static const textMuted = Color(0xFF8A93A3);
  static const link = Color(0xFF1B4B5A);
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final provider = context.read<RegisterProvider>();
    final success = await provider.register(
      fullName: _fullNameController.text,
      studentId: _studentIdController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      agreedToTerms: _agreedToTerms,
    );

    if (!mounted) return;

    if (success) {
      
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } else if (provider.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(provider.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();

    return Scaffold(
      // backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: 
        IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
  
        title: const Text('Library',style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.primary,
                ),),
                centerTitle: true,
      ),

      // SizedBox(width: 48), // balances the back button

      body: 
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildFormCard(provider),
                      const SizedBox(height: 28),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildFormCard(RegisterProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Join the Archive',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Access a world of academic excellence and classic literature.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 28),
          _fieldLabel('Full Name'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _fullNameController,
            hint: 'Enter your full name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          _fieldLabel('Student ID'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _studentIdController,
            hint: 'e.g. 2024-XXXXX',
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 20),
          _fieldLabel('Email Address'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailController,
            hint: 'name@university.edu',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _fieldLabel('Password'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _passwordController,
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            trailing: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 20),
          _fieldLabel('Confirm'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _confirmPasswordController,
            hint: '••••••••',
            icon: Icons.replay_outlined,
            obscureText: _obscureConfirmPassword,
            trailing: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
              onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
          const SizedBox(height: 18),
          _buildTermsCheckbox(),
          const SizedBox(height: 24),
          _buildRegisterButton(provider),
          const SizedBox(height: 20),
          _buildLoginLink(),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textDark),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA6ADBB)),
          prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
          suffixIcon: trailing,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: _agreedToTerms,
            activeColor: AppColors.primary,
            onChanged: (value) =>
                setState(() => _agreedToTerms = value ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text.rich(
              TextSpan(
                text: 'I agree to the ',
                style:
                    const TextStyle(color: AppColors.textDark, fontSize: 13),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.link,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        
                      },
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Library Regulations.',
                    style: TextStyle(
                      color: AppColors.link,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(RegisterProvider provider) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: provider.isLoading
          ? null
          : () async {
              final success = await provider.register(
                fullName: _fullNameController.text,
                studentId: _studentIdController.text,
                email: _emailController.text,
                password: _passwordController.text,
                confirmPassword: _confirmPasswordController.text,
                agreedToTerms: _agreedToTerms,
              );

              if (!mounted) return;

              if (success) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => CostomButtom()),
                  (route) => false,
                );
              } else if (provider.errorMessage != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(provider.errorMessage!)));
              }
            },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: provider.isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                'Register',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

 Widget _buildLoginLink() {
  return Center(
    child: RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: const TextStyle(color: AppColors.textDark, fontSize: 14),
        children: [
          TextSpan(
            text: 'Login',
            style: TextStyle(color: AppColors.link, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
          ),
        ],
      ),
    ),
  );
}

  Widget _buildFooter() {
    return Column(
      children: const [
        Icon(Icons.menu_book_outlined, size: 26, color: AppColors.textMuted),
        SizedBox(height: 10),
        Text(
          '© 2024 Academic Digital Library System',
          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ],
    );
  }
}