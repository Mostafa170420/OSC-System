import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.title,
      required this.icon,
      required this.controller,
      required this.validator,
      this.maxLines = 1,
      this.alignlableWithHint = false,
      this.readOnly = false});
  final String? Function(String?)? validator;
  final String title;
  final bool readOnly;
  final IconData icon;
  final TextEditingController controller;
  final maxLines;

  final dynamic alignlableWithHint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          alignLabelWithHint: alignlableWithHint,
          hintText: title,
          fillColor: Theme.of(context).cardColor,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
