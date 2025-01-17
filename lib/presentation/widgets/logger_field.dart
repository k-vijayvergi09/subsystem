import 'package:flutter/material.dart';

class LoggerField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? prefixText;

  const LoggerField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixText: prefixText,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
} 