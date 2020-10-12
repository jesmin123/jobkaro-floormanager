
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class PendingTab extends StatefulWidget {
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(PENDING,style: AppFontStyle.headingTextStyle(PRIMARY_COLOR),));
  }
}
