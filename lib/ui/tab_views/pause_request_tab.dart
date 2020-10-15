

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/ui/widget/pause_request_item.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class PauseRequestTab extends StatefulWidget {
  @override
  _PauseRequestTabState createState() => _PauseRequestTabState();
}

class _PauseRequestTabState extends State<PauseRequestTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,position){
          return PauseRequestItem();
        },
        separatorBuilder: (context,position){
          return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
        },
        itemCount: 6
    );

  }
}
