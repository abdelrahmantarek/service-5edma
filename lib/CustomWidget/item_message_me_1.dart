


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ItemMessageMe1 extends StatelessWidget {
  final String message;
  final String time;
  const ItemMessageMe1({Key? key, required this.message, this.time = "22:11 pm"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color:Theme.of(context).primaryColor,),
                      child: RichText(
                        textDirection:TextDirection.rtl,
                        maxLines: null,
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 9.sp,
                                fontFamily: "Poppins",
                                color: Colors.white),
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
                                    color: Colors.white70),
                              ),
                            )),


                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
