

import 'package:flutter/material.dart';


class CustomIcon1 extends StatelessWidget {
  final Widget? icon;
  final Color? backColor;
  final GestureTapCallback? onTap;
  final Widget? child;
  final double height;
  final double width;
  final double padding;
  const CustomIcon1({Key? key, this.icon, this.backColor, this.onTap, this.child, this.height = 40, this.width = 40,this.padding = 10})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(child: Container(
            padding: EdgeInsets.all(padding),
            decoration: backColor == Colors.transparent ? null : BoxDecoration(
              color: backColor ?? Colors.white38,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.01),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 0.5), // changes position of shadow
                ),
              ],
            ),
            child: FittedBox(
              child: child != null ? child : icon != null ? icon : SizedBox(),
            ),
          )),

          Positioned.fill(child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap:onTap,
            ),
          ))

        ],
      ),
    );

  }
}
