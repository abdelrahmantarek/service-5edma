import 'package:flutter/material.dart';

import '../style/color_manager.dart';

/// A class that creates a text field with a label and a suffix icon.
class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final FormFieldValidator<String> validate;
  final String hintText;
  final Widget? suffix;
  final IconData? prefixIcon;
  final bool isPassword;
  final String? helpText;

  const DefaultFormField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.validate,
      required this.hintText,
      this.suffix,
      this.isPassword = false,
      this.prefixIcon,
      this.helpText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      cursorColor: ColorManager.primary,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2!
          .copyWith(fontSize: 19, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        hintText: hintText,
        helperText: helpText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: ColorManager.primary) : null,
        suffixIcon: suffix,
      ),
    );
  }
}
