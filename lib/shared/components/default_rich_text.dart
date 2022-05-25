import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/color_manager.dart';

class DefaultRichText extends StatelessWidget {
  final String text;
  final TextStyle? headStyle;
  final TextStyle? subTextStyle;
  const DefaultRichText({Key? key, required this.text,this.headStyle,this.subTextStyle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        text: text.tr,
        style:headStyle ?? Theme.of(context).textTheme.bodyText2,
        children: [
          if(true)
            TextSpan(
              text: ' *',
              style:subTextStyle?? Theme.of(context).textTheme.bodyText1!.copyWith(
                color: ColorManager.red,
              ),
            ),
        ],
      ),
    );
  }
}
