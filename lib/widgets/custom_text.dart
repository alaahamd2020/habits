import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign alignment;
  final Color? color;
  final bool bold;

  const TextCustom(this.text, {super.key, this.fontSize, this.alignment = TextAlign.start, this.color, this.bold =false});


  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: bold? FontWeight.bold :FontWeight.normal,
      ),
    );
  }
}
