import 'package:bharatrail/constants/constants.dart';
import 'package:flutter/material.dart';

// File to store constants required across the application with slight modifications

// Set fontstyle for the application
TextStyle urbanist(Color color,
    {double? fontsize = fontSizeMedium, FontWeight? weight = FontWeight.w400}) {
  return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: fontsize,
      fontWeight: weight);
}

// Padding defaults
EdgeInsets setPadding(
    {double left = 16, double right = 16, double top = 0, double bottom = 0}) {
  return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
}
