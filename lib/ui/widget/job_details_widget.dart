import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:provider/provider.dart';

class JobDetailsWidget extends StatefulWidget {
  TeamModel employeeDetails;


  JobDetailsWidget(this.employeeDetails);

  @override
  _JobDetailsWidgetState createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    JobCardProvider jobCardProvider  = Provider.of<JobCardProvider>(context);
    return Column(
   children: [
     CircleAvatar(
       backgroundColor: PRIMARY_COLOR,
       radius: 32,
       backgroundImage: CachedNetworkImageProvider('https://www.adbasis.com/images/divita-a65623c8.jpg'),
     ),
     Text(
       widget.employeeDetails.name,
       style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),
     ),
     Text(
       'Technician',
       style: AppFontStyle.labelTextStyle3(APP_GREY_COLOR),
     ),
   ],
    );
  }
}
