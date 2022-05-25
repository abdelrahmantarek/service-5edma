import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:overlay_support/overlay_support.dart';


class EmptyList extends StatelessWidget {
  final GestureTapCallback? onTap;
  final dynamic iconData;
  final String text;
  const EmptyList({this.onTap,this.iconData = Icons.list, this.text = "فارغ"});
  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(child: iconData is IconData ? Icon(iconData,color: Colors.black,size: 80,) : iconData,opacity: 0.2,),
            SizedBox(height: 10,),
            Opacity(child: Container(
              margin: EdgeInsets.only(right: 100,left: 100),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(text,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30.sp),)),
            ),opacity: 0.8,),
          ],
        ),
      ),
    );
  }
}



class EmptyWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final double? textSize;
  final double? iconSize;
  const EmptyWidget({this.icon, this.title, this.textSize, this.iconSize});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title!,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: textSize ?? 30.sp),),
              Icon(icon,size:iconSize ?? 25.sp,color: Colors.grey.withOpacity(0.5),),
            ],
          )
      ),
    );
  }
}


success(String text){
  showSimpleNotification(
      Text(text,style: TextStyle(fontSize: 10.sp),),
      background: Colors.green);
}
error(String text){
  showSimpleNotification(
      Text(text,style: TextStyle(fontSize: 10.sp)),
      background: Colors.red);
}