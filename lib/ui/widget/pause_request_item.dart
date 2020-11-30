import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:line_icons/line_icons.dart';

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
                IconButton(onPressed: (){},icon: Icon(Icons.call_outlined, size: ICON_SIZE,),focusColor: PRIMARY_COLOR,),
                SizedBox(width:LINE_HEIGHT*0.1),
                IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow_outlined, size: ICON_SIZE,),),
                SizedBox(width: LINE_HEIGHT*0.1),
                IconButton(onPressed: (){}, icon: Icon(Icons.pause_outlined, size: ICON_SIZE,),),
                SizedBox(width: LINE_HEIGHT),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Reason :', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),),
                Text('Welding machine is not working',  style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR))
              ],
            ),
          ),
        ]
    );
  }
}
