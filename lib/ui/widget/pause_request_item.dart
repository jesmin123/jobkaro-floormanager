
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';

class PauseRequestItem extends StatefulWidget {
  @override
  _PauseRequestItemState createState() => _PauseRequestItemState();
}

class _PauseRequestItemState extends State<PauseRequestItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Maruti Alto',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
            subtitle: Text('KL-17-C-563 ', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
            trailing:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(EvaIcons.phoneCallOutline, size: ICON_SIZE ,color: APP_BLACK_COLOR),
                SizedBox(width: LINE_HEIGHT),
                Icon(EvaIcons.playCircleOutline, size: ICON_SIZE, color: APP_BLACK_COLOR),
                SizedBox(width: LINE_HEIGHT),
                Icon(EvaIcons.pauseCircleOutline, size: ICON_SIZE ,color: APP_BLACK_COLOR),
                SizedBox(width: LINE_HEIGHT),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Reason: Welding machine is not working', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
          ),
        ]
    );
  }
}
