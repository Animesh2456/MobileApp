import 'package:flutter/material.dart';

class Textfieldcustom extends StatefulWidget {
  final String label;
  final String value; //  passing String here
  final InputDecoration? decoration;
  final double? fontSize;
  final FontWeight? fontWeight;

  const Textfieldcustom({
    super.key,
    required this.label,
    required this.value,
    this.decoration,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<Textfieldcustom> createState() => _TextfieldcustomState();
}

class _TextfieldcustomState extends State<Textfieldcustom> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    // Convert string to controller
    controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    controller.dispose(); // clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      style: TextStyle(
        fontSize: widget.fontSize ?? 12,
        fontWeight: widget.fontWeight ?? FontWeight.normal,
      ),
      decoration: widget.decoration ??
          InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
          ),
    );
  }
}
