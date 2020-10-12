import 'package:flutter/material.dart';
import '../../constants/app_font_style.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class PauseRequestTab extends StatefulWidget {
  @override
  _PauseRequestTabState createState() => _PauseRequestTabState();
}

class _PauseRequestTabState extends State<PauseRequestTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(PAUSE_REQUEST,style: AppFontStyle.headingTextStyle(PRIMARY_COLOR),));
  }
}
