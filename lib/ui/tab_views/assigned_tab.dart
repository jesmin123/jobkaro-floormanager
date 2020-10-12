
import 'package:flutter/material.dart';
import '../../constants/app_font_style.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class AssignedTab extends StatefulWidget {
  @override
  _AssignedTabState createState() => _AssignedTabState();
}

class _AssignedTabState extends State<AssignedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(ASSIGNED,style: AppFontStyle.headingTextStyle(PRIMARY_COLOR),));
  }
}
