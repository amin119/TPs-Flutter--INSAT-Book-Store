import 'package:flutter/material.dart';

InputDecoration CustomInputDecoration(
    String label, String hint, Icon prefixIcon) {
  return InputDecoration(
    label: Text(label),
    hintText: hint,
    prefixIcon: prefixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
