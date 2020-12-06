import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/finished_Item.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';


class FinishedTab extends StatefulWidget {
  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {

  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);
    return jobCardProvider.completedServiceRequest.length==0?Center(child: Text('No Data',style: AppFontStyle.bodyTextStyle(Colors.grey,textSize: 22.0),)):ListView.separated(shrinkWrap: true,
        itemBuilder: (context,position){
          ServiceRequestModel service = jobCardProvider.completedServiceRequest[position];
        return FinishedItem(service);
        },
      separatorBuilder: (context, index) {
        return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
      },
    itemCount: jobCardProvider.completedServiceRequest.length
    );
  }
}
