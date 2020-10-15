import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/ui/widget/finished_Item.dart';
import '../../constants/colors.dart';


class FinishedTab extends StatefulWidget {
  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(shrinkWrap: true,

        itemBuilder: (context,position){
        return FinishedItem();
        },
      separatorBuilder: (context, index) {
        return Divider(color: APP_BLACK_COLOR, thickness: THICKNESS,);
      },
    itemCount: 6
    );
  }
}
