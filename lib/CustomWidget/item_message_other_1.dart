

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class ItemMessageOther1 extends StatelessWidget {
  final String message;
  final String time;
  const ItemMessageOther1({Key? key, required this.message,required this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 13),
                      margin: const EdgeInsets.only(right: 12,left: 12),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0.0, 0.3),
                              color: Colors.grey.withOpacity(0.4))
                        ],
                        borderRadius: BorderRadius.all(const Radius.circular(10)),
                        color:Colors.white,),
                      child: RichText(
                        textDirection:TextDirection.rtl,
                        maxLines: null,
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 9.sp,
                                fontFamily: "Poppins",
                                color: Colors.black),
                            text:message,
                            children: [


                              WidgetSpan(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  time,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 6.sp,
                                      fontFamily: "Poppins",
                                      color: Colors.grey),
                                ),
                              )),

                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}