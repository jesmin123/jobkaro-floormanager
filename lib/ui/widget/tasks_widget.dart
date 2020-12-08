
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:provider/provider.dart';
import '../../model/JobModel.dart';

class TasksWidget extends StatefulWidget {
  JobModel item;

  TasksWidget(this.item);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 12,left: 12),
        child: CircleAvatar(
            radius: CIRCLE_SIZE,
            backgroundColor: widget.item.getLeadingColor()
        ),
      ),
      title: Text(widget.item.task.name, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),),
      subtitle: widget.item.techinican==null?Text("Not assigned"):Text(jobCardProvider.getTeamMember(widget.item.techinican.id).name, style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${widget.item.getTimeTaken()}:00 / ${widget.item.task.minute}:00'
              ' m',style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 14.0)),
        ],
      ),
    );
  }
}
