import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class ThemeManager {
  ThemeManager._();

  static ThemeData get lightTheme => _lightTheme;

  static ThemeData get darkTheme => _darkTheme;

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: buildMaterialColor(ColorManager.primary))
        .copyWith(secondary: ColorManager.grey),

    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey,

    // ripple color
    splashColor: ColorManager.transparent,
    //primaryOpacity70
    highlightColor: ColorManager.transparent,

    // card view theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: 4.0,
    ),

    /// Setting the background color of the scaffold.
    scaffoldBackgroundColor: ColorManager.white,

    // appBarTheme: const AppBarTheme(
    //   titleSpacing: 20.0,
    //   elevation: 0.0,
    //   centerTitle: true,
    //   color: ColorManager.white,
    //   titleTextStyle: TextStyle(
    //     color: ColorManager.textBlack,
    //     fontSize: 25.0,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   iconTheme: IconThemeData(color: ColorManager.primary,size: 28),
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: ColorManager.primary,
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // ),

    iconTheme: const IconThemeData(
      color: ColorManager.primary,
    ),



    // Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primary,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:  TextStyle(
          fontSize: 12,
          fontFamily: FontManager.currentFontFamily,
          color: ColorManager.white,
          fontWeight: FontWeight.w400,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8.0),
      prefixIconColor: ColorManager.primary,
      suffixIconColor: ColorManager.primary,
      isCollapsed: true,

      // hint style
      hintStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: ColorManager.textGrey,
        fontFamily: FontManager.currentFontFamily,
      ),

      // label style
      labelStyle: TextStyle(
        fontSize: 12,
        fontFamily: FontManager.currentFontFamily,
        color: ColorManager.textBlack,
        fontWeight: FontWeight.w500,
      ),
      // error style
      errorStyle: TextStyle(
        fontSize: 12,
        fontFamily: FontManager.currentFontFamily,
        color: ColorManager.red,
        fontWeight: FontWeight.w400,
      ),

      //  border
      border: const UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.grey)),

      // enabled border
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.grey)),

      // focused border
      focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.primary)),

      // error border
      errorBorder:const UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.red)),

      // focused error border
      focusedErrorBorder:const UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.primary)),

    ),

    // Text theme
    fontFamily: FontManager.currentFontFamily,
    textTheme: const TextTheme(
      //semi-bold: 22s black
      headline5: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: ColorManager.textBlack,
      ),

      //Regular: 17s  grey
      bodyText1: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: ColorManager.textGrey,
      ),

      //Regular: 15s  black
      bodyText2: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: ColorManager.textBlack,
      ),

      //semi-bold: 14s  green
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: ColorManager.primary,
      ),

      //semi-bold: 12s black
      subtitle2: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: ColorManager.textBlack,
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData();
}
