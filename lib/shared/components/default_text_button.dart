import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final Function function;
  final String text;
  final bool isUpperCase;

  const DefaultTextButton({
    Key? key,
    required this.function,
    required this.text,
    this.isUpperCase = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          function();
        },
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 20),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // alignment: Alignment.centerRight
        ),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1!
              .copyWith(fontSize: 13, decoration: TextDecoration.underline),
        ));
  }
}
