
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:provider/provider.dart';


class FinishedItem extends StatefulWidget {

  final ServiceRequestModel service;

  FinishedItem(this.service);

  @override
  _FinishedItemState createState() => _FinishedItemState();
}

class _FinishedItemState extends State<FinishedItem> {
  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('${widget.service.make} ${widget.service.model}',style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),),
            subtitle: Text('${widget.service.regNo}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
            trailing: IconButton(onPressed: (){
                jobCardProvider.selectedService = widget.service;
                Navigator.pushNamed(context, FINISHED_DETAILS_PAGE);
              },icon: Icon(Icons.arrow_forward_rounded,size: ICON_SIZE,color: PRIMARY_COLOR,))
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text( '${widget.service.jobModel.length} tasks  | ${widget.service.timeofCompletion.substring(0,10)}', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),),
          ),
        ]
    );
  }
}
