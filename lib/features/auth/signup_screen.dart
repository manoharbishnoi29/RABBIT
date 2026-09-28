import 'package:flutter/material.dart';
import '../../services/local_storage_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _step = 1; // 1: Email, 2: OTP, 3: Set Username & Password

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final String _generatedOtp = "123456"; // Dummy OTP for testing

  void _sendOtp() {
    if (_emailController.text.trim().isEmpty || !_emailController.text.contains('@')) {
      _showSnackBar('Please enter a valid Gmail address');
      return;
    }
    setState(() => _step = 2);
    _showSnackBar('OTP sent to ${_emailController.text}');
  }

  void _verifyOtp() {
    if (_otpController.text.trim() == _generatedOtp) {
      setState(() => _step = 3);
    } else {
      _showSnackBar('Wrong OTP! Try again.');
    }
  }

  void _completeSignup() async {
    if (_usernameController.text.trim().isEmpty) {
      _showSnackBar('Please enter a username');
      return;
    }
    if (_passwordController.text.isEmpty || _passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match!');
      return;
    }

    // Save user credentials locally
    await LocalStorageService.saveUserCredentials(
      _usernameController.text.trim(),
      _passwordController.text,
    );

    _showSnackBar('Data saved successfully! Please login.');
    if (mounted) Navigator.pop(context);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign Up (Step $_step/3)', style: const TextStyle(color: Colors.amber)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (_step == 1) ...[
              const Text('Enter your Gmail to receive OTP', style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Enter your gmail'),
              const SizedBox(height: 20),
              _buildButton('Get OTP', _sendOtp),
            ] else if (_step == 2) ...[
              Text('OTP sent to ${_emailController.text}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              _buildTextField(_otpController, 'Enter OTP here'),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _showSnackBar('OTP resent! Check code 123456'),
                child: const Text('Resend OTP', style: TextStyle(color: Colors.amber)),
              ),
              const SizedBox(height: 12),
              _buildButton('Submit OTP', _verifyOtp),
            ] else if (_step == 3) ...[
              _buildTextField(_usernameController, 'Write username'),
              const SizedBox(height: 12),
              _buildTextField(_passwordController, 'Set Password', isObscure: true),
              const SizedBox(height: 12),
              _buildTextField(_confirmPasswordController, 'Re-enter Password', isObscure: true),
              const SizedBox(height: 20),
              _buildButton('Submit', _completeSignup),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
