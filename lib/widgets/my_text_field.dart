import 'package:flutter/material.dart';
import 'package:habits/widgets/custom_text.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String? init;
  final int? fontSize;
  final Color? color;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final TextInputType? typeInput;

  MyTextField({
    required this.hint,
    this.init,
    this.fontSize,
    this.color,
    this.validator,
    this.onSubmitted,
    this.typeInput,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: init,
      autofocus: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hint: TextCustom(hint), fillColor: color),
      validator: validator,
      onFieldSubmitted: onSubmitted,
      keyboardType: typeInput,
    );
  }
}
