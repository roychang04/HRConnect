import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'hr@company.com');
  final _passwordController = TextEditingController(text: 'hr123');
  final _authService = const AuthService();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {  // Changed && to ||
      setState(() {
        _errorMessage = 'Email and password are required.';
      });
      return;
    }

    final user = _authService.login(email, password);
    if (user == null) {
      setState(() {
        _errorMessage = 'Invalid email or password.';
      });
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      '/dashboard',
      arguments: user,  // Deleted .email
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.business_center, size: 64),
                    const SizedBox(height: 12),
                    Text(
                      'HRConnect',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Try HR: hr@company.com / hr123'
                      'Try Employee: employee@company.com / emp123',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
