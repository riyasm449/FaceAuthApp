
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Commons{
  static const tileBackgroundColor = Color(0xFFF1F1F1);
  static const gradientBackgroundColorEnd = Color(0xFF601A36);
  static const gradientBackgroundColorWhite = Color(0xFFFFFFFF);
  static const mainAppFontColor = Color(0xFF4D0F29);
  static const appBarBackGroundColor = Color(0xFF4D0F28);
  static const categoriesBackGroundColor = Color(0xFFA8184B);
  static const hintColor = Color(0xFF4D0F29);
  static const mainAppColor = Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = Color(0xFF4D0F29);
  static const popupItemBackColor = Color(0xFFDADADB);
  static Color commonThemeColor = Commons.colorFromHex('#131131');
  static Color greyAccent1 = Commons.colorFromHex('#f7f7f7');
  static Color greyAccent2 = Commons.colorFromHex('#cccccc');
  static Color greyAccent3 = Commons.colorFromHex('#999999');
  static Color greyAccent4 = Commons.colorFromHex('#8e8e93');
  static Color greyAccent5 = Commons.colorFromHex('#333333');

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Widget appHeader(String text, BuildContext context){
    return SafeArea(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: commonThemeColor,
        ),
        child: Text(text,style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),),
      ),
    );
  }
}

final appTheme = ThemeData(
  primaryColor: Commons.commonThemeColor,
  primarySwatch: Colors.indigo,
  unselectedWidgetColor: Colors.white,
  accentIconTheme: const IconThemeData(color: Colors.black),
  textTheme: const TextTheme(bodyText1: TextStyle(fontFamily: 'Helvetica')),
  iconTheme: IconThemeData(color: Commons.commonThemeColor),
  fontFamily: 'Helvetica',
  hintColor: Commons.hintColor,
);