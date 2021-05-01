import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppIcons {
  static AppIcons? _instance;
  static AppIcons get instance => _instance ??= AppIcons();

  final IconData mail = Icons.mail_rounded;
  final IconData password = Icons.lock_outline_rounded;

  final IconData visibility = Icons.visibility_rounded;
  final IconData visibilityOff = Icons.visibility_off_rounded;

  final IconData repository = Icons.book_rounded;
  final IconData team = Icons.people_rounded;
  final IconData logout = MdiIcons.logout;
}
