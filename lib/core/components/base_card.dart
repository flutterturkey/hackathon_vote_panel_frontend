import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: child,
      );
}
