import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/PauseTaskModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/pause_request_item.dart';
import 'package:provider/provider.dart';

class PauseRequestTab extends StatefulWidget {
  @override
  _PauseRequestTabState createState() => _PauseRequestTabState();
}

class _PauseRequestTabState extends State<PauseRequestTab> {
  @override
  Widget build(BuildContext context) {

    JobCardProvider jobCardProvider  = Provider.of(context);
    return ListView.separated(shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,position){
          PauseTaskModel model = jobCardProvider.pauseRequests[position];
          return PauseRequestItem(model);
        },
        separatorBuilder: (context,position){
          return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
        },
        itemCount: jobCardProvider.pauseRequests.length
    );

  }
}
