import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.label,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(label),
        ),
      );
}
