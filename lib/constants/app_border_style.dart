import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimen.dart';

class AppBorderStyle{

  static UnderlineInputBorder getFormBorder({Color color}){
    return  UnderlineInputBorder(
        borderSide: BorderSide(width: BORDER_WIDTH,color: color!=null?color:APP_BORDER_COLOR,)
    );
  }

  static BoxDecoration appFormBorder({Color color}){
    return  BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        border: Border.all(width: BORDER_WIDTH,color:APP_BORDER_COLOR,)
    );
  }
}