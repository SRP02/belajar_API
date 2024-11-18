import 'package:flutter/material.dart';
import 'package:belajar_api/utils/authservice.dart';
import 'package:belajar_api/helpers/auth_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

Future<void> _handleRegister() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);

    try {
      final response = await AuthService().register(
        _usernameController.text,
        _passwordController.text,
        _fullNameController.text,
        _emailController.text,
      );

      if (response.status) {
        // Simpan nickname ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nickname', _usernameController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthHelpers.buildTextField(
                controller: _usernameController,
                labelText: 'Username',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter username' : null,
              ),
              const SizedBox(height: 16),
              AuthHelpers.buildTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter password' : null,
              ),
              const SizedBox(height: 16),
              AuthHelpers.buildTextField(
                controller: _fullNameController,
                labelText: 'Full Name',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter full name' : null,
              ),
              const SizedBox(height: 16),
              AuthHelpers.buildTextField(
                controller: _emailController,
                labelText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter email';
                  if (!value.contains('@')) return 'Please enter valid email';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AuthHelpers.buildSubmitButton(
                onPressed: _handleRegister,
                text: 'Register',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
