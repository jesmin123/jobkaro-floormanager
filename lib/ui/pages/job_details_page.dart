import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/job_details_widget.dart';
import 'package:job_karo_floor_manager/ui/widget/tasks_widget.dart';
import 'package:provider/provider.dart';
import '../../model/ServicerequestModel.dart';
import '../../model/JobModel.dart';

class JobDetailsPage extends StatefulWidget {
  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

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
                      title: Text('Team', style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR,textSize: 20.0),),
                      trailing: Text('4 Members', style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        height: 100,
                        child: ListView.separated(
                          separatorBuilder: (_,pos)=>SizedBox(width: 8,),
                            itemCount: 17,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_,pos){
                              if(pos==0){
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: PRIMARY_COLOR,
                                      radius: 32,
                                      child: Icon(
                                        Icons.person_add_alt_1_outlined,
                                        color: APP_WHITE_COLOR,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      'Add new',
                                      style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),
                                    ),
                                  ],
                                );
                              }else{
                                return JobDetailsWidget();
                              }
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
                              return TasksWidget(item);
                             }),
                    service.getOverTimeTask().length==0?Container():Column(
                      children: [
                        ListTile(leading: Text(OVER_TIME, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 20.0),)),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:  service.getOverTimeTask().length,
                            itemBuilder: (context, pos){
                              JobModel item  = service.getOverTimeTask()[pos];
                              return TasksWidget(item);
                            }
                        ),
                        SizedBox(height: LINE_HEIGHT*3,)
                      ],
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () async {
                    //todo add loaders
                   bool status = await jobCardProvider.markServiceAsCompleted(userProvider.user.jwt , service.id);
                   // todo show toast message
                   if(status){
                     Navigator.pop(context);
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
                        Text(MARK_COMPLETED, style: AppFontStyle.headingTextStyle(APP_WHITE_COLOR, textSize: 18.0),),
                        SizedBox(width: ICON_WIDTH,),
                        Icon(Icons.done_all_outlined, color: APP_WHITE_COLOR,)
                      ],
                    ),
                  ),

                ),
              ),
            ],
          )
      ),
    );
  }
}
