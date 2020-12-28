
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/JobModel.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/job_details_widget.dart';
import 'package:job_karo_floor_manager/ui/widget/rework_task_widget.dart';
import 'package:job_karo_floor_manager/ui/widget/tasks_widget.dart';
import 'package:job_karo_floor_manager/utils/LoaderUtils.dart';
import 'package:provider/provider.dart';

class FinishedDetailPage extends StatefulWidget {
  @override
  _FinishedDetailPageState createState() => _FinishedDetailPageState();
}

class _FinishedDetailPageState extends State<FinishedDetailPage> {

  @override
  Widget build(BuildContext context) {

    final JobCardProvider jobCardProvider = Provider.of(context);
    final UserProvider userProvider = Provider.of(context);

    ServiceRequestModel service = jobCardProvider.selectedService;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: APP_WHITE_COLOR,), onPressed: (){Navigator.pop(context);}),
        title: Text(JOB_DETAILS, style: AppFontStyle.headingTextStyle(APP_WHITE_COLOR, textSize: 20.0),),
      ),
      body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(service.model+' '+ service.make, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),),
                      subtitle: Text(service.regNo, style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
                      trailing: Text('Issued on : ' + service.timeofCreation.substring(0,10), style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
                    ),
                    ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Team', style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR,textSize: 20.0),),
                            Text('${service.assignedTechnicians.length} Members', style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: service.assignedTechnicians.length==0? Text('No Employee Assigned', style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR),):Container(
                        height: 110,
                        child: ListView.separated(
                            separatorBuilder: (_,pos)=>SizedBox(width: 8,),
                            itemCount: service.assignedTechnicians.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_,pos){
                                return JobDetailsWidget(service.assignedTechnicians[pos]);
                            }
                        ),
                      ),
                    ),
                    SizedBox(height: LINE_HEIGHT*0.5,),
                    ListTile(
                      leading: Text(
                        'Tasks',
                        style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR,textSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14,left: 14, bottom: 12,top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: CIRCLE_SIZE,
                                  backgroundColor: APP_GREEN_COLOR
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(service.getProgressStatus()[2].toString(), style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                              SizedBox(width: ICON_WIDTH,),
                              CircleAvatar(
                                radius: CIRCLE_SIZE,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(service.getProgressStatus()[1].toString(), style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                              SizedBox(width: ICON_WIDTH,),
                              CircleAvatar(
                                radius: CIRCLE_SIZE,
                                backgroundColor: APP_GREY_COLOR,
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(service.getProgressStatus()[0].toString(), style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: CIRCLE_SIZE,
                                  backgroundColor: APP_GREEN_COLOR
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(FINISHED_, style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                              SizedBox(width: ICON_WIDTH,),
                              CircleAvatar(
                                radius: CIRCLE_SIZE,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(ON_GOING, style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                              SizedBox(width: ICON_WIDTH,),
                              CircleAvatar(
                                radius: CIRCLE_SIZE,
                                backgroundColor: APP_GREY_COLOR,
                              ),
                              SizedBox(width: ICON_WIDTH*0.5,),
                              Text(NOT_STARTED, style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: service.jobModel.length,
                        itemBuilder: (context, pos){
                          JobModel item  = service.jobModel[pos];
                          if(item.task==null){
                            return Container();
                          }else{
                            return ReworkTaskWidget(item);
                          }

                        }),
                    SizedBox(height: LINE_HEIGHT*3,)
                  ],
                ),
              ),
            ],
          )
      ),
    );

  }


}
