import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/PauseTaskModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/utils/LaunchUtils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class PauseRequestItem extends StatefulWidget {

 final  PauseTaskModel model;

  PauseRequestItem(this.model);


  @override
  _PauseRequestItemState createState() => _PauseRequestItemState();
}

class _PauseRequestItemState extends State<PauseRequestItem> {

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of(context);
    JobCardProvider jobCardProvider = Provider.of(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('${widget.model.taskModel.name}',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.model.pauseItemModel.make} ${widget.model.pauseItemModel.model}',style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
                Text('${widget.model.pauseItemModel.regNo}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
              ],
            ),
            trailing:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){LaunchUtils.makeCall(widget.model.technician.mobile);},icon: Icon(LineIcons.phone, size: ICON_SIZE,color: PRIMARY_COLOR,),focusColor: PRIMARY_COLOR,),
                SizedBox(width:LINE_HEIGHT*0.1),
                widget.model.status=="5"?IconButton(onPressed: (){jobCardProvider.pauseTask(userProvider.user.jwt, widget.model.id);},
                  icon: Icon(LineIcons.play_circle_o, size: ICON_SIZE,color: PRIMARY_COLOR,),):
                IconButton(onPressed: (){jobCardProvider.resumeTask(userProvider.user.jwt, widget.model.id);}, icon: Icon(Icons.pause_circle_outline, size: ICON_SIZE,color: PRIMARY_COLOR,),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Reason : ', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),),
                Text('${widget.model.pauseLogModel!=null?widget.model.pauseLogModel.reason:"No reason"}',  style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR))
              ],
            ),
          ),
        ]
    );
  }
}
