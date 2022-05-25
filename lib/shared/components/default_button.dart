import 'package:flutter/material.dart';
import '../style/color_manager.dart';

/// A custom button that has a default style
class DefaultButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function onPressed;
  final bool isUppercase;
  final double radius;
  final String text;
  final Color buttonColor;

  const DefaultButton({
    Key? key,
    this.width,
    required this.onPressed,
    this.isUppercase = false,
    this.radius = 35.0,
    required this.text,
    this.height,
    this.buttonColor = ColorManager.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.079,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () => onPressed(),
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
            color: ColorManager.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}