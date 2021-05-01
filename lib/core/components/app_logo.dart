import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    required this.height,
    Key? key,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/logo.png',
        height: height,
      );
}
