

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class EditBox1 extends StatelessWidget {
  final GestureTapCallback onTapSend;
  final TextEditingController controller;
  final String? hint;
  const EditBox1({Key? key, required this.onTapSend, required this.controller, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        scrollPadding: const EdgeInsets.symmetric(vertical: 10),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: 11.sp,
                        ),
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value){

                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                          hintText:hint ?? "Type message",
                          alignLabelWithHint: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey,
                            fontSize: 11.sp,
                          ),
                          labelStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    )),


              ],
            ),
          ),
        ),

        Container(width: 5,),

        FloatingActionButton(
          heroTag: " ",
          mini: true,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed:onTapSend,
          child: const Icon(
            Icons.send,color: Colors.white,
            size: 17,
          ),
        ),

      ],
    );
  }
}
