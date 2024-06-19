import 'dart:ui';

import 'package:flutter/material.dart';

class Colours {
  static const red = Color(0xffDF2832);
  static const white = Colors.white;
  static const lightRed = Color(0xffE8666D);
  static const black = Colors.black;
  static const textLightBlack = Color(0xff4c4c4c);

  appBarTitle() {
    return const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500);
  }

  tileText() {
    return const TextStyle(
        color: lightRed, fontSize:13, fontWeight: FontWeight.w600);
  }

  tileStyle() {
    return const TextStyle(
        color: Colours.textLightBlack,fontWeight: FontWeight.w500);
  }
}
