
import 'package:flutter/cupertino.dart';



class MiniLoading extends StatelessWidget {
  const MiniLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CupertinoActivityIndicator(),
    );
  }
}
