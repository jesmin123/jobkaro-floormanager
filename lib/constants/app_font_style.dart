
import 'package:flutter/material.dart';

class AppFontStyle{

  static TextStyle titleAppBarStyle(Color color, {num textSize}) {
      return TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w300,
        fontFamily: "Exo"
      );
  }

  static TextStyle buttonTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: "Exo"
    );
  }

  static TextStyle bodyTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: "Exo"
    );
  }

  static TextStyle headingTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: "Exo"
    );
  }

  static TextStyle regularHeadingTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFamily: "Exo"
    );
  }

  static TextStyle regularTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: "Exo"
    );
  }

  static TextStyle labelTextStyle(Color color, {num textSize}) {
    return TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w200,
        fontFamily: "Exo"
    );
  }

}