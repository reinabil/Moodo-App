import 'package:flutter/material.dart';

class Style {
  Color styleColor;

  Style({this.styleColor = Colors.black});

  TextStyle get header => TextStyle(
        color: styleColor,
        fontSize: 24,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get title1 => TextStyle(
        color: styleColor,
        fontSize: 28,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get title2 => TextStyle(
        color: styleColor,
        fontSize: 22,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline => TextStyle(
        color: styleColor,
        fontSize: 20,
        fontFamily: "Poppins",
      );

  TextStyle get body => TextStyle(
        color: styleColor,
        fontSize: 14,
        fontFamily: "Poppins",
      );

  TextStyle get caption => TextStyle(
        color: styleColor,
        fontSize: 12,
        fontFamily: "Poppins",
      );

  final LinearGradient gradasi = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xff65db9f), Color(0xff3da0a6)]);

  final LinearGradient gradasi2 = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xff3da0a6), Color(0xff65db9f)]);
}
