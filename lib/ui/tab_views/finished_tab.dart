import 'package:flutter/material.dart';
import '../../constants/app_font_style.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class FinishedTab extends StatefulWidget {
  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(FINISHED,style: AppFontStyle.headingTextStyle(PRIMARY_COLOR),));
  }
}
