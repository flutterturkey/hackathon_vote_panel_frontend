import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    this.label,
    this.secure,
    this.autoFocus,
    this.validator,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onEditingComplete,
    Key? key,
  }) : super(key: key);

  final String? label;
  final bool? secure;
  final bool? autoFocus;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: secure ?? true,
        obscureText: secure ?? false,
        autofocus: autoFocus ?? false,
        controller: controller,
        validator: validator,
        maxLines: 1,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: () => onEditingComplete,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      );
}
