

import 'package:flutter/material.dart';

import 'CustomIcon1.dart';



class CustomAppSliverBar extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? backgroundLeadingColor;
  final Color? titleColor;
  const CustomAppSliverBar({Key? key,required this.title, this.backgroundColor, this.backgroundLeadingColor, this.titleColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      floating: true,
      pinned: true,
      elevation: 0,
      actions: [

        Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            const SizedBox(width: 20,),

            CustomIcon1(
              onTap: (){
                Navigator.pop(context);
              },
              backColor:backgroundLeadingColor ?? Theme.of(context).primaryColor,
              icon:const Padding(
                padding: EdgeInsets.all(3),
                child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
              ),
            ),

            Expanded(child: Container(
              alignment: Alignment.center,
              child:Text(
                title,
                style:TextStyle(
                  fontSize: 19,
                  color:titleColor ?? const Color(0xff2a2e43),
                  height: 1.5185185185185186,
                ),
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            )),


            const SizedBox(width: 40,),
            const SizedBox(width: 20,),

          ],
        )),


      ],
    );
  }
}
