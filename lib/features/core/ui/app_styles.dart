import 'package:flutter/material.dart';

class AppStyles {
  static InputDecoration textField(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.all(12),
    );
  }
}
