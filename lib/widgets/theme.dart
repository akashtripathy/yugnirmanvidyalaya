import 'package:flutter/material.dart';

class MyTheme {
  static Color myWhite = Color(0xffffffff);
  static Color myBlack = Color(0xff403c4d);
  static Color myBlack2 = Color(0xff78777C);
  static Color myYellow = Color(0xffebd484);
  static Color myGrey = Color(0xffc4c4c4);
  static Color myGrey2 = Color(0xffEFEEEE);

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: myBlack,
        // buttonColor: myBlack,
      );

  static ThemeData darTheme(BuildContext context) => ThemeData(
        primaryColor: myBlack,
      );
}
