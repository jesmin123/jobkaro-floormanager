import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/rework_item_widget.dart';
import 'package:provider/provider.dart';

class ReworksTab extends StatefulWidget {
  @override
  _ReworksTabState createState() => _ReworksTabState();
}

class _ReworksTabState extends State<ReworksTab> {

  @override
  Widget build(BuildContext context) {

    JobCardProvider jobCardProvider = Provider.of(context);
    return ListView.builder(
      itemBuilder: (_,pos){
        return ReworkTaskItem(jobCardProvider.reworks[pos]);
      },
      itemCount: jobCardProvider.reworks.length,
    );
  }
}
