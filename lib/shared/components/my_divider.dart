import 'package:flutter/material.dart';
import '../style/color_manager.dart';

class MyDivider extends StatelessWidget {
  final bool vertMarg;
  const MyDivider({Key? key, this.vertMarg = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: vertMarg ? const EdgeInsets.symmetric(vertical: 12):null,
      width: double.infinity,
      height: 1,
      color: ColorManager.grey,
    );
  }
}