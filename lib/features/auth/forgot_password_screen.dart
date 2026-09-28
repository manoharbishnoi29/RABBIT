import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _step = 1;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _sendOtp() {
    if (_emailController.text.contains('@')) {
      setState(() => _step = 2);
    }
  }

  void _verifyOtp() {
    if (_otpController.text == '123456') {
      setState(() => _step = 3);
    }
  }

  void _resetPassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully! Please login.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('Forgot Password', style: TextStyle(color: Colors.amber))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (_step == 1) ...[
              _buildField(_emailController, 'Enter Gmail'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _sendOtp, child: const Text('Get OTP')),
            ] else if (_step == 2) ...[
              _buildField(_otpController, 'Enter OTP'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _verifyOtp, child: const Text('Submit OTP')),
            ] else ...[
              _buildField(_newPasswordController, 'Enter New Password', obscure: true),
              const SizedBox(height: 12),
              _buildField(_confirmPasswordController, 'Re-enter Password', obscure: true),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _resetPassword, child: const Text('Update Password')),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String label, {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
