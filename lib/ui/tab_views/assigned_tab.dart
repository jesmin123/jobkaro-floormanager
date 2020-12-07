
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/assigned_item.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../model/ServicerequestModel.dart';


class AssignedTab extends StatefulWidget {
  @override
  _AssignedTabState createState() => _AssignedTabState();
}

class _AssignedTabState extends State<AssignedTab> {
  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);
    return jobCardProvider.serviceRequests.length==0?Center(child: Text('No Data',style: AppFontStyle.bodyTextStyle(Colors.grey,textSize: 22.0),)): ListView.separated(shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,position){
          ServiceRequestModel item = jobCardProvider.serviceRequests[position];
          return AssignedItem(item);
        },
        separatorBuilder: (context,position){
          return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
        },
        itemCount: jobCardProvider.serviceRequests.length
    );
  }

}
