import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextStyles {
  static final TextStyle TeamDetailSubtitle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue[900]);
}

class AppColors {
  AppColors._();

  static Color appColor = const Color(0xFF5d4ab4);
  static Color basicColor = const Color(0xFF293241);
  static Color cardColor = const Color(0xff001219);
  static Color backgroundColor = const Color(0xFF000000);

  static Color failed = const Color(0xFFD4EDDA);
  static Color success = const Color(0xFF40AD64);
  static Color pending = const Color(0xFFA3B83C);
  static Color alert = const Color(0xFFF56B76);
}
