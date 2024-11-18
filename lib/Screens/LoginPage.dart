import 'package:belajar_api/Screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:belajar_api/utils/authservice.dart';
import 'package:belajar_api/Screens/RegisterPage.dart';
import 'package:belajar_api/helpers/auth_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PostView.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  

Future<void> _handleLogin() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);

    try {
      final response = await AuthService().login(
        _usernameController.text,
        _passwordController.text,
      );

      if (response.status) {
        // Simpan token dan nickname ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token ?? '');
        await prefs.setString('nickname', _usernameController.text);

        // Tampilkan snackbar dengan token
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login berhasil! Token: ${response.token ?? ''}'),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Pindah ke dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Login failed')),
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 24),
              AuthHelpers.buildSubmitButton(
                onPressed: _handleLogin,
                text: 'Login',
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
