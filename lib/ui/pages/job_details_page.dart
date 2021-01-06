import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/new_task_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/widget/job_details_widget.dart';
import 'package:job_karo_floor_manager/ui/widget/tasks_widget.dart';
import 'package:job_karo_floor_manager/utils/LoaderUtils.dart';
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
                        height: 140,
                        child: ListView.separated(
                          separatorBuilder: (_,pos)=>SizedBox(width: 8,),
                            itemCount: service.assignedTechnicians.length+1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_,pos){
                                if(pos == 0){
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 32.0,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showEmployeeDialog(service.assignedTechnicians,userProvider.user.jwt);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: PRIMARY_COLOR,
                                                radius: 32,
                                                child: Icon(
                                                  Icons.person_add,
                                                  color: APP_WHITE_COLOR,
                                                  size: 24,
                                                ),
                                              ),
                                              Text(
                                                'Add new',
                                                style: AppFontStyle.labelTextStyle3(
                                                    APP_BLACK_COLOR),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else{
                                  return JobDetailsWidget(service.assignedTechnicians[pos-1]);
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
                      trailing: InkWell(
                        onTap: () {
                          showTaskDialog(jobCardProvider.selectedService.jobModel,userProvider.user.jwt);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: PRIMARY_COLOR),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 4, bottom: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: APP_WHITE_COLOR,
                                  size: 16,
                                ),
                                Text(
                                  "Add task",
                                  style: AppFontStyle.labelTextStyle2(APP_WHITE_COLOR),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                return TasksWidget(item);
                              }

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
                              if(item.task==null){
                                return Container();
                              }else{
                                return TasksWidget(item);
                              }

                            }
                        ),
                        SizedBox(height: LINE_HEIGHT*3,)
                      ],
                    ),
                    SizedBox(height: LINE_HEIGHT*3,)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () async {
                    Loader.getLoader(context).show();
                        bool status = await jobCardProvider.markServiceAsCompleted(userProvider.user.jwt , service.id);
                    Loader.getLoader(context).hide();
                        if(status){
                          toast('Case Closed Successfully');
                          Navigator.pop(context);
                        }
                        else{
                          toast('Failed to Complete Case');
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

  showEmployeeDialog(List<TeamModel> assignedTechnicians,String jwt){

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) {
            final JobCardProvider jobCardProvider = Provider.of(context);
            final NewtaskProvider newTaskProvider = Provider.of(context);

            List<TeamModel> remainingTechnicians =[];

            for(int i=0;i<jobCardProvider.allEmployees.length;i++){
              bool status = false;
              for(int j=0;j<assignedTechnicians.length;j++) {
                  if(jobCardProvider.allEmployees[i].id==assignedTechnicians[j].id){
                    status = true;
                    break;
                  }
              }
              if(!status){
                remainingTechnicians.add(jobCardProvider.allEmployees[i]);
              }
            }
            return AlertDialog(
              scrollable: true,
              content: Container(
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.height/1.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Assign Employee for the JobCard',
                        style: AppFontStyle.headingTextStyle(
                            APP_BLACK_COLOR), textAlign: TextAlign.center,),
                      SizedBox(height: LINE_HEIGHT,),
                      Stack(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, pos) {
                              TeamModel technician = remainingTechnicians [pos];
                              return CheckboxListTile(
                                value: newTaskProvider.checkTechicianExists(
                                    technician),
                                subtitle: Column(
                                  mainAxisSize:
                                  MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      TECHNICIAN,
                                      style: AppFontStyle
                                          .headingTextStyle(
                                          APP_BLACK_COLOR,
                                          textSize: 12.0),
                                    ),
                                    Text(
                                      'Emp Code :' +
                                          technician.empCode,
                                      style: AppFontStyle
                                          .labelTextStyle4(
                                          APP_BLACK_COLOR),
                                    ),
                                    Text(
                                        'Mobile No :' + technician.mobile,
                                        style: AppFontStyle
                                            .labelTextStyle4(
                                            APP_BLACK_COLOR)),
                                  ],
                                ),
                                title: Text(
                                  technician.name,
                                  style: AppFontStyle
                                      .headingTextStyle(
                                      APP_BLACK_COLOR,
                                      textSize: 16.0),
                                ),
                                onChanged: (val) {
                                  if (val) {
                                    TeamModel techie = remainingTechnicians [pos];
                                    techie.synced = -1;
                                    jobCardProvider.selectedService.assignedTechnicians.add(techie);
                                  }else {
                                    jobCardProvider.selectedService.assignedTechnicians.remove(remainingTechnicians [pos]);
                                  }
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount:remainingTechnicians.length,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                      SizedBox(height: LINE_HEIGHT,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            child: RaisedButton(
                              onPressed: () {
                                jobCardProvider.updateSelectedService(jwt);
                                Navigator.pop(context);
                              },
                              color: PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(32)
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: APP_WHITE_COLOR,
                                    size: ICON_SIZE * 0.7,
                                  ),
                                  Text('Update',
                                      style: AppFontStyle
                                          .labelTextStyle2(
                                          APP_WHITE_COLOR)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });

  }

  showTaskDialog(List<JobModel> jobModel, String jwt){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) {

            final JobCardProvider jobCardProvider = Provider.of(context);
            final NewtaskProvider newTaskProvider = Provider.of(context);
            List<TaskModel> remainingJobs =[];

            for(int i=0;i<jobCardProvider.allTasks.length;i++){
              bool status = false;
              for(int j=0;j<jobModel.length;j++) {
                if(jobModel[j].task==null){
                  continue;
                }
                if(jobCardProvider.allTasks[i].id==jobModel[j].task.id){
                  status = true;
                  break;
                }
              }
              if(!status){
                remainingJobs.add(jobCardProvider.allTasks[i]);
              }
            }
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height/1.2,
                width: MediaQuery.of(context).size.height/1.5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: LINE_HEIGHT * 2,
                      ),
                      Text('Assign time for task',
                          style: AppFontStyle.headingTextStyle(
                              APP_BLACK_COLOR)),
                      SizedBox(
                        height: LINE_HEIGHT,
                      ),
                      ListView.builder(
                        itemBuilder: (context, pos) {
                          TaskModel task  = remainingJobs[pos];
                          return CheckboxListTile(
                            value: remainingJobs[pos].selected,
                            subtitle: Column(
                              mainAxisSize:
                              MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.minute+" Minutes",
                                  style: AppFontStyle
                                      .headingTextStyle(
                                      APP_BLACK_COLOR,
                                      textSize: 12.0),
                                ),
                              ],
                            ),
                            title: Text(
                              task.name,
                              style: AppFontStyle
                                  .headingTextStyle(
                                  APP_BLACK_COLOR,
                                  textSize: 16.0),
                            ),
                            onChanged: (val){
                              if(val){
                                remainingJobs[pos].selected = true;
                              }else{
                                remainingJobs[pos].selected = false;
                              }
                            },
                          );
                        },
                        shrinkWrap: true,
                        itemCount: remainingJobs.length,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(
                        height: LINE_HEIGHT,
                      ),
                      SizedBox(
                        height: LINE_HEIGHT * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 130,
                            child: RaisedButton(
                              onPressed: () {
                                jobCardProvider.updateServiceJobs(jwt, remainingJobs);
                                Navigator.pop(context);
                              },
                              color: PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(32)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: APP_WHITE_COLOR,
                                    size: ICON_SIZE*0.7,
                                  ),
                                  Text('| Update',
                                      style: AppFontStyle
                                          .labelTextStyle2(
                                          APP_WHITE_COLOR)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }


}
