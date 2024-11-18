import 'package:flutter/material.dart';

class AuthHelpers {
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.white;

  static Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  static Widget buildSubmitButton({
    required VoidCallback onPressed,
    required String text,
    bool isLoading = false,
  }) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          );
  }
}
