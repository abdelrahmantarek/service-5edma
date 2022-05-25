
import 'package:flutter/material.dart';



class CustomButton1 extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final Color? color;
  const CustomButton1({
    Key? key,
    this.onTap,
    required this.text,
    this.color,
    this.iconData,
  }) : super(key: key);
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if(iconData != null) const SizedBox(
            width: 4,
          ),
          if(iconData != null) Icon(
            iconData!,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
      color: color,);
  }
}
