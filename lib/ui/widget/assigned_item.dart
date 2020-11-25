import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/ui/pages/job_details_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AssignedItem extends StatefulWidget {
  @override
  _AssignedItemState createState() => _AssignedItemState();
}

class _AssignedItemState extends State<AssignedItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){Navigator.pushNamed(context, JOB_DETAILS_PAGE);},
      isThreeLine: true,
        title: Text('Maruti Alto',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KL-17-C-563 ', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
            SizedBox(height: 4),
            Text('4'+ " "+ASSIGNED, style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),)
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          CircularStepProgressIndicator(
          totalSteps: 100,
          currentStep: 80,
          selectedColor: PRIMARY_COLOR,
          stepSize: 5,
          unselectedColor: APP_GREY_COLOR,
          padding: 0,
          width:50,
          height: 50,
            child: Center(child: Text('80%',)),
          selectedStepSize: 4,
          roundedCap: (_, __) => true,
        ),
            SizedBox(width:16),
            Icon(LineIcons.arrow_circle_o_right,size: ICON_SIZE,color: APP_BLACK_COLOR,)
          ],
        )
    );
  }
}
