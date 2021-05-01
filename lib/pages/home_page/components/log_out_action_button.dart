import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/util/app_icons.dart';

class LogOutActionButton extends StatelessWidget {
  const LogOutActionButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(AppIcons.instance.logout, color: Colors.white),
              const SizedBox(width: 10),
              const Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
}
