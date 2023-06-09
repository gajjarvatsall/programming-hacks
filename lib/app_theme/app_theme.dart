import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
  );
  static InputDecoration inputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    focusColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
  );
}
