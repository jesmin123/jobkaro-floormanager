import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/ui/widget/job_details_widget.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 12,left: 12),
        child: CircleAvatar(
            radius: CIRCLE_SIZE,
            backgroundColor: APP_GREEN_COLOR
        ),
      ),
      title: Text('Oil Changing', style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),),
      subtitle: Text('Alex Thomas', style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('13:00 / 15:00 m',style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 14.0)),
          SizedBox(width: LINE_HEIGHT*0.5,),
          PopupMenuButton(
            icon: Icon(Icons.edit_road_outlined),
              // ignore: missing_return
              itemBuilder: (context,)=>[
                PopupMenuItem(child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.loop_outlined), onPressed: (){}),
                    SizedBox(width: ICON_WIDTH,),
                    Text(RE_ASSIGN_JOB, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),)
                  ],
                )
                )
              ]
              )
        ],
      ),
    );
  }
}
