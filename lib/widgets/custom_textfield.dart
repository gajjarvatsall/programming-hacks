import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const CustomTextField({
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    super.key,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: validator,
      cursorColor: Colors.black,
      // magnifierConfiguration: TextMagnifierConfiguration(),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade200,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade500),
        ),
        // errorText: 'Enter email',
        errorStyle: TextStyle(color: Colors.red.shade300),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
