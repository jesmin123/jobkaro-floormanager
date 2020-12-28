
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/utils/LoaderUtils.dart';
import 'package:provider/provider.dart';
import '../../model/JobModel.dart';

class ReworkTaskWidget extends StatefulWidget {
  final JobModel item;

  ReworkTaskWidget(this.item);

  @override
  _ReworkTaskWidgetState createState() => _ReworkTaskWidgetState();
}

class _ReworkTaskWidgetState extends State<ReworkTaskWidget> {
  @override
  Widget build(BuildContext context) {

    final JobCardProvider jobCardProvider = Provider.of(context);
    final UserProvider userProvider = Provider.of(context);

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 12,left: 12),
        child: CircleAvatar(
            radius: CIRCLE_SIZE,
            backgroundColor: widget.item.getLeadingColor()
        ),
      ),
      title: Text(widget.item.task.name, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),),
      subtitle: widget.item.techinican==null?Text("Not assigned"):Text(jobCardProvider.getTeamMember(widget.item.techinican.id).name, style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),),
      trailing:  RaisedButton(
        onPressed: () async {
          Loader.getLoader(context).show();
          RespObj response  = await jobCardProvider.addToReworkTasks(userProvider.user.jwt, widget.item.task.id);
          Loader.getLoader(context).hide();
          if(response.getStatus()){
            toast("Rework added successfully");
          }else{
            toast(response.msg);
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        color: PRIMARY_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Rework", style: AppFontStyle.headingTextStyle(APP_WHITE_COLOR, textSize: 18.0),),
            ],
          ),
        ),

      ),
    );
  }


  toast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: APP_RED_COLOR,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
