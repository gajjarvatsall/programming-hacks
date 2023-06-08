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
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      // magnifierConfiguration: TextMagnifierConfiguration(),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey.shade200,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade500),
        ),
        // errorText: 'Enter email',
        errorStyle: TextStyle(color: Colors.red.shade300),
        // filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
        ),
      ),
    );
  }
}
