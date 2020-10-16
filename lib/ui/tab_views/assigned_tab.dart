
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/ui/widget/assigned_item.dart';
import '../../constants/colors.dart';


class AssignedTab extends StatefulWidget {
  @override
  _AssignedTabState createState() => _AssignedTabState();
}

class _AssignedTabState extends State<AssignedTab> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,position){
          return AssignedItem();
        },
        separatorBuilder: (context,position){
          return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
        },
        itemCount: 6
    );
  }
}
