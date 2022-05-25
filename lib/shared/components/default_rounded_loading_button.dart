import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../style/color_manager.dart';

///rounded loading button
class DefaultRoundedLoadingButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function onPressed;
  final bool isUppercase;
  final double radius;
  final String text;
  final Color buttonColor;
  final RoundedLoadingButtonController controller;

  const DefaultRoundedLoadingButton({
    Key? key,
    this.width,
    required this.onPressed,
    this.isUppercase = false,
    this.radius = 20.0,
    required this.text,
    this.height,
    this.buttonColor = ColorManager.primary,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      animateOnTap: false,
      borderRadius: radius,
      onPressed: () => onPressed(),
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.079,
      color: buttonColor,
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: ColorManager.white,
              fontSize: 20,
            ),
      ),
    );
  }
}
