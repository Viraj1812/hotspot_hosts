import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/config/assets/fonts.gen.dart';

class AppStyles {
  static const FontWeight _light = FontWeight.w400;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _regular = FontWeight.w600;
  static const FontWeight _bold = FontWeight.w700;
  static const FontWeight _extraBold = FontWeight.w900;

  static TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color? color,
    TextDecoration? decoration,
    String? fontFamily,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: AppFonts.spaceGrotesk,
      decoration: decoration,
    );
  }

  static TextStyle getLightStyle({double? fontSize, Color? color, TextDecoration? decoration, String? fontFamily}) {
    return _getTextStyle(fontSize ?? 12, _light, color ?? AppColors.white, decoration, fontFamily);
  }

  static TextStyle getMediumStyle({double? fontSize, Color? color, TextDecoration? decoration, String? fontFamily}) {
    return _getTextStyle(fontSize ?? 12, _medium, color ?? AppColors.white, decoration, fontFamily);
  }

  static TextStyle getRegularStyle({double? fontSize, Color? color, TextDecoration? decoration, String? fontFamily}) {
    return _getTextStyle(fontSize ?? 14, _regular, color ?? AppColors.white, decoration, fontFamily);
  }

  static TextStyle getBoldStyle({double? fontSize, Color? color, TextDecoration? decoration, String? fontFamily}) {
    return _getTextStyle(fontSize ?? 18, _bold, color ?? AppColors.white, decoration, fontFamily);
  }

  static TextStyle getExtraBoldStyle({double? fontSize, Color? color, TextDecoration? decoration, String? fontFamily}) {
    return _getTextStyle(fontSize ?? 18, _extraBold, color ?? AppColors.white, decoration, fontFamily);
  }
}
