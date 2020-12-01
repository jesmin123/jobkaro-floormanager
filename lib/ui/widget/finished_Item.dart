
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:line_icons/line_icons.dart';


class FinishedItem extends StatefulWidget {
  @override
  _FinishedItemState createState() => _FinishedItemState();
}

class _FinishedItemState extends State<FinishedItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Maruti Alto',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
            subtitle: Text('KL-17-C-563 ', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('25-06-2020',style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),),
                SizedBox(width:LINE_HEIGHT),
                IconButton(onPressed: (){},icon: Icon(Icons.arrow_forward_rounded,size: ICON_SIZE,color: PRIMARY_COLOR,))
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text( '41 tasks', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
          ),
        ]
    );
  }
}
