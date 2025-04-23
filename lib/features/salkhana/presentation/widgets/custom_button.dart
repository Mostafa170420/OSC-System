import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.title, required this.color, this.onPressed});
  final String title;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 60,
      minWidth: 300,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        overflow: TextOverflow.clip,
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
      ),
    );
  }
}
