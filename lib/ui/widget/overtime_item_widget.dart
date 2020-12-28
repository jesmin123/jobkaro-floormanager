
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/OverTimetaskModel.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';


class OvertimeItem extends StatefulWidget {

  final OverTimeTaskModel overTimeTaskModel;

  OvertimeItem(this.overTimeTaskModel);

  @override
  _OvertimeItemState createState() => _OvertimeItemState();
}

class _OvertimeItemState extends State<OvertimeItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              title: Text('${widget.overTimeTaskModel.job.name}',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
              subtitle: Text('${widget.overTimeTaskModel.technican.name}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${widget.overTimeTaskModel.getTimeTaken()}:00 / ${widget.overTimeTaskModel.job.minute}:00'
                      ' m',style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 14.0)),
                  SizedBox(width:LINE_HEIGHT),
                  //IconButton(onPressed: (){},icon: Icon(Icons.arrow_forward_rounded,size: ICON_SIZE,color: PRIMARY_COLOR,))
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text( '${widget.overTimeTaskModel.request.regNo}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
          ),
        ]
    );
  }
}
