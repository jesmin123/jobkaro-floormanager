import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../model/ServicerequestModel.dart';

class AssignedItem extends StatefulWidget {
  final ServiceRequestModel item;

  AssignedItem(this.item);

  @override
  _AssignedItemState createState() => _AssignedItemState();
}

class _AssignedItemState extends State<AssignedItem> {

  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);
    return ListTile(
      onTap: (){
        jobCardProvider.selectedService = widget.item;
        Navigator.pushNamed(context, JOB_DETAILS_PAGE);
        },
      isThreeLine: true,
        title: Text("${widget.item.make} ${widget.item.model} ",style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.regNo, style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
            SizedBox(height: 4),
            Text('${widget.item.assignedTechnicians.length} $ASSIGNED', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),)
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: widget.item.getTaskCompletedPercent(),
            selectedColor: PRIMARY_COLOR,
            stepSize: 3,
            unselectedColor: APP_GREY_COLOR,
            padding: 0,
            width:45,
            height: 45,
            selectedStepSize: 3,
            child: Center(child: Text('${widget.item.getTaskCompletedPercent()}%', style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),)),
          roundedCap: (_, __) => true,
        ),
            SizedBox(width:16),
            Icon(Icons.arrow_forward_rounded,size: ICON_SIZE,color: PRIMARY_COLOR,)
          ],
        )
    );
  }
}
