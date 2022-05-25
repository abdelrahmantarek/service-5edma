



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



extension StringVS on String{

  String toMoney(){
    if(num.parse(this) == 0){
      return "0.0";
    }
    return NumberFormat.currency(customPattern: '\u00a4 #',locale: null,decimalDigits: 2,symbol: "").format(num.parse(this)).toString();
  }

  String get euro{
    return this + " €";
  }

  bool get isUrl{
    return Uri.tryParse(this)?.hasAbsolutePath ?? false;
  }

  num get toNumber{
    return num.parse(this);
  }


}


extension StyleV on BuildContext{


  TextStyle get small1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(10),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }


  TextStyle get small2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(12.5),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }


  TextStyle get small3{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }



  TextStyle get title1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }


  TextStyle get subtitle1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.98,
      color: const Color(0xff707070),
    );
  }

  TextStyle get title2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(18),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get title3{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(21),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get title5{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(26),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get subtitle2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.98,
      color: const Color(0xff707070),
    );
  }

  TextStyle get subtitle3{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.98,
      fontWeight: FontWeight.w200,
      color: const Color(0xff707070),
    );
  }


  TextStyle get body1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.90,
      color:Colors.black,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get body2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      height: 0.98,
      color: const Color(0xff707070),
    );
  }


  TextStyle get accent1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: textSize(15),
      color:Get.theme.accentColor,
    );
  }

  TextStyle get accent2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize: 12,
      color:Get.theme.accentColor,
    );
  }

  TextStyle get accent3{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize:textSize(12),
      color:Get.theme.accentColor,
    );
  }

  TextStyle get appBar1{
    return TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: textSize(21),
      color: const Color(0xff000000),
      letterSpacing: 0.63,
      height: 1.4761904761904763,
      fontWeight: FontWeight.w600,
      // shadows: [
      //   Shadow(
      //     color: const Color(0x4d000000),
      //     offset: Offset(0, 6),
      //     blurRadius: 18,
      //   )
      // ],
    );
  }


  TextStyle get appBar2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize:textSize(15),
      color:Colors.black,
      fontWeight: FontWeight.w100
    );
  }

  TextStyle get flex1{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize:textSize(30),
      color:Colors.black,
    );
  }

  TextStyle get flex2{
    return TextStyle(
      fontFamily: 'Helvetica Neue',
      fontSize:textSize(30),
      color:Colors.black,
    );
  }


  double textSize(double d){
    return d;
    return (d * 1 / 100);
  }

}