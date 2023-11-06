import 'package:flutter/material.dart';
import 'package:udenwa_prosper/src/res/hex_color.dart';

class AppColor {
  AppColor._();

  ///light
  static Color primaryColor = HexColor("#4476F6");
  static Color secondaryColor = HexColor("#3A3A3A");
  static Color textColor = secondaryColor;
  static Color accentColor = HexColor("#F6C144");
  static Color disabledColor = secondaryColor.withOpacity(0.5);
  static Color errorColor = Colors.red;
}
