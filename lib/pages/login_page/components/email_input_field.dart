import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/components/app_text_field.dart';
import 'package:hackathon_panel/core/util/app_icons.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 350,
        child: AppTextField(
          controller: controller,
          label: 'Email Adresi',
          autoFocus: true,
          secure: false,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          prefixIcon: Icon(AppIcons.instance.mail),
          textInputType: TextInputType.emailAddress,
          validator: (email) {
            if (EmailValidator.validate(email!)) {
              return null;
            } else {
              return 'Geçersiz email';
            }
          },
        ),
      );
}
