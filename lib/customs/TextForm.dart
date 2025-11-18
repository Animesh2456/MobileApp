import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIconData;
  final InputDecoration? decoration;
   final double? fontSize;
   final FontWeight? fontWeight;
  final double? iconSize;
  final Color? iconColor;


  const TextForm({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIconData,
    this.decoration,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: fontWeight ?? FontWeight.normal, // Make it bold
          fontSize: fontSize ?? 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        prefixIcon: prefixIconData != null
            ? Icon(
          prefixIconData,
          size: iconSize ?? 24.0,
          color: iconColor ?? Colors.blue,
        )
            : null,
        filled: true,
        fillColor:const Color(0xFFF7F8F9),
      ),
    );
  }
}
