import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/model/OverTimetaskModel.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/finished_Item.dart';
import 'package:job_karo_floor_manager/ui/widget/overtime_item_widget.dart';
import 'package:provider/provider.dart';

class OvertimeTasksFragment extends StatefulWidget {
  @override
  _OvertimeTasksFragmentState createState() => _OvertimeTasksFragmentState();
}

class _OvertimeTasksFragmentState extends State<OvertimeTasksFragment> {

  @override
  Widget build(BuildContext context) {
    JobCardProvider jobCardProvider  = Provider.of(context);
    return ListView.builder(
        itemBuilder: (_,pos){
          OverTimeTaskModel service  = jobCardProvider.overtimeTasks[pos];
          return OvertimeItem(service);
        },
      itemCount: jobCardProvider.overtimeTasks.length,
    );
  }
}
