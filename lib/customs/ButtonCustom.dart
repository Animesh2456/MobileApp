import 'package:flutter/material.dart';

class Buttoncustom extends StatelessWidget {


  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final Size? minimumsize;

  const Buttoncustom({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight=FontWeight.bold,
    this.borderRadius = 12,
    //this.minimumsize=const Size(125, 53),
    //or below
    this.minimumsize,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        minimumSize: minimumsize ?? const Size(125, 53), //minimum size of button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, color: textColor,fontWeight:fontWeight),
      ),
    );
  }
}
