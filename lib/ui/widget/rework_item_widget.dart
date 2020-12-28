
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/ReworksModel.dart';


class ReworkTaskItem extends StatefulWidget {

  final ReworksModel reworksModel;

  ReworkTaskItem(this.reworksModel);

  @override
  _ReworkTaskItemState createState() => _ReworkTaskItemState();
}

class _ReworkTaskItemState extends State<ReworkTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              title: Text('${widget.reworksModel.job.name}',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
              subtitle: Text('', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${widget.reworksModel.getTimeTaken()}:00 / ${widget.reworksModel.job.minute}:00'
                      ' m',style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 14.0)),
                  SizedBox(width:LINE_HEIGHT),
                  //IconButton(onPressed: (){},icon: Icon(Icons.arrow_forward_rounded,size: ICON_SIZE,color: PRIMARY_COLOR,))
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text( '${widget.reworksModel.request.regNo}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
          ),
        ]
    );
  }
}
