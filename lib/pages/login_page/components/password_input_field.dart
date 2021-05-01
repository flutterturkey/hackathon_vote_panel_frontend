import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/components/app_text_field.dart';
import 'package:hackathon_panel/core/util/app_icons.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 350,
        child: AppTextField(
          controller: widget.controller,
          label: 'Parola',
          secure: isSecure,
          prefixIcon: Icon(AppIcons.instance.password),
          suffixIcon: buildShowHidePasswordButton,
          autofillHints: AutofillHints.password,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          validator: (val) => val!.isEmpty ? 'Şifre boş bırakılamaz' : null,
        ),
      );

  Widget get buildShowHidePasswordButton => IconButton(
        icon: buildAnimatedCrossFade,
        onPressed: () => setState(() => isSecure = !isSecure),
      );

  CrossFadeState get isCrossFadeState =>
      isSecure ? CrossFadeState.showFirst : CrossFadeState.showSecond;

  AnimatedCrossFade get buildAnimatedCrossFade => AnimatedCrossFade(
        crossFadeState: isCrossFadeState,
        firstCurve: Curves.easeInBack,
        firstChild: Icon(AppIcons.instance.visibility),
        secondChild: Icon(AppIcons.instance.visibilityOff),
        duration: const Duration(milliseconds: 300),
      );
}
