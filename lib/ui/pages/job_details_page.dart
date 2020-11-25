import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/ui/widget/job_details_widget.dart';
import 'package:job_karo_floor_manager/ui/widget/tasks_widget.dart';

class JobDetailsPage extends StatefulWidget {
  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                      title: Text('Maruti Alto', style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),),
                      subtitle: Text('KL-17-C-539', style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
                      trailing: Text('Issued on: 2 OCT 2020', style: AppFontStyle.labelTextStyle2(APP_GREY_COLOR),),
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
                      trailing: InkWell(
                        onTap: () {
                          return showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16))),
                              context: context,
                              builder: (BuildContext bc) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
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
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  20.0, 10.0, 20.0, 10.0),
                                              hintText: 'Enter task',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(16)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(16))),
                                        ),
                                        SizedBox(
                                          height: LINE_HEIGHT,
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          height: 40,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('10.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('15.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('20.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('25.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('30.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('35.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('40.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('45.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('50.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                              SizedBox(width: LINE_HEIGHT*0.5,),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: BorderSide(color: APP_BLACK_COLOR)),
                                                child: Text('55.00 m', style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR)),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: LINE_HEIGHT*2,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: RaisedButton(
                                                onPressed: () {},
                                                color: PRIMARY_COLOR,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.done, color: APP_WHITE_COLOR,),
                                                    Text('Save', style: AppFontStyle.labelTextStyle2(APP_WHITE_COLOR)),
                                                  ],
                                                ),),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              });
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
                             Text('11', style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                             SizedBox(width: ICON_WIDTH,),
                             CircleAvatar(
                               radius: CIRCLE_SIZE,
                               backgroundColor: PRIMARY_COLOR,
                             ),
                             SizedBox(width: ICON_WIDTH*0.5,),
                             Text('11', style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
                             SizedBox(width: ICON_WIDTH,),
                             CircleAvatar(
                               radius: CIRCLE_SIZE,
                               backgroundColor: APP_GREY_COLOR,
                             ),
                             SizedBox(width: ICON_WIDTH*0.5,),
                             Text('11', style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),),
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
                        itemCount: 6,
                            itemBuilder: (context, pos){
                            return TasksWidget();
                             }
                             ),
                    ListTile(leading: Text(OVER_TIME, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 20.0),)),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, pos){
                          return TasksWidget();
                        }
                    ),
                    SizedBox(height: LINE_HEIGHT*3,)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(onPressed: (){},
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
