
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/new_task_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'EmpAvatarWidget.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController _modelController = TextEditingController();
  TextEditingController _makeController = TextEditingController();
  TextEditingController _regNoController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _customerContactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final singleValidator = MultiValidator([
    RequiredValidator(errorText: 'this field is required'),
  ]);

  get checkboxValue => null;

  @override
  Widget build(BuildContext context) {
    final NewtaskProvider newTaskProvider = Provider.of(context);
    final UserProvider userProvider = Provider.of(context);

    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Vehicle Details",
                  style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _modelController,
              validator: singleValidator,
              decoration: InputDecoration(
                  labelText: "Model*", focusColor: APP_BLACK_COLOR),
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _makeController,
              validator: singleValidator,
              decoration: InputDecoration(
                  labelText: "Make*", focusColor: APP_BLACK_COLOR),
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _regNoController,
              decoration: InputDecoration(labelText: "Reg No.*"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: "Customer Name*"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _customerContactController,
              decoration: InputDecoration(labelText: "Customer Contact*"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: "DMS Job Card Number*"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: 'ERP Job Card Number*'),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            ListTile(
              leading: Text('Team',
                  style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR)),
              trailing: Text('${newTaskProvider.selectedEmployees.length} members'),
            ),
            Container(
              height: 100,
              child: ListView.separated(
                separatorBuilder: (_, pos) => SizedBox(
                  width: 8,
                ),
                shrinkWrap: true,
                itemCount: newTaskProvider.selectedEmployees.length+1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, pos) {
                  if (pos == 0) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 32.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              showEmployeeDialog();
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
                    TeamModel employee = newTaskProvider.selectedEmployees[pos-1];
                    return EmpAvatarWidget(employee);
                  }
                },
              ),
            ),
            ListTile(
              leading: Text(
                'Tasks',
                style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),
              ),
              trailing: InkWell(
                onTap: () {
                  showTaskDialog();
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: newTaskProvider.selectedTask.length,
                itemBuilder: (_,pos){
                TaskModel task = newTaskProvider.selectedTask[pos];
                  return CheckboxListTile(
                    value:  newTaskProvider.checkTaskExists(task),
                    onChanged: (val){
                      if(val){
                        newTaskProvider.addToSelectedTask(task);
                      }else{
                        newTaskProvider.removeFromSelectedTask(task);
                      }
                    },
                    title: Text(task.name, style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR, textSize: 16.0),),
                    subtitle: Text('${task.minute} Minutes', style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),),
                  );
                }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    RespObj response = await newTaskProvider.CreateRequest(
                        _modelController.text,
                        _makeController.text,
                        _regNoController.text,
                        _customerNameController.text,
                        _customerContactController.text,
                        userProvider
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: PRIMARY_COLOR,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Submit',
                    style: AppFontStyle.labelTextStyle2(APP_WHITE_COLOR),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showTaskDialog(){
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          final JobCardProvider jobCardProvider = Provider.of(context);
          final NewtaskProvider newTaskProvider = Provider.of(context);
          return AlertDialog(
            content: Column(
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
                    TaskModel task  = jobCardProvider.allTasks[pos];
                    return CheckboxListTile(
                      value: newTaskProvider.checkTaskExists(task),
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
                          newTaskProvider.addToSelectedTask(task);
                        }else{
                          newTaskProvider.removeFromSelectedTask(task);
                        }
                      },
                    );
                  },
                  shrinkWrap: true,
                  itemCount: jobCardProvider.allEmployees.length,
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
                      width: 100,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: PRIMARY_COLOR,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(32)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: APP_WHITE_COLOR,
                              size: ICON_SIZE*0.7,
                            ),
                            Text('| Close',
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
          );
        });
  }

  showEmployeeDialog(){
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          final JobCardProvider jobCardProvider = Provider.of(context);
          final NewtaskProvider newTaskProvider = Provider.of(context);
          return AlertDialog(
            scrollable: true,
            content: Column(
              children: [
                Text('Assign Employee for the JobCard', style: AppFontStyle.headingTextStyle(
                    APP_BLACK_COLOR), textAlign: TextAlign.center,),
                SizedBox(height: LINE_HEIGHT,),
                Stack(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, pos) {
                        TeamModel technician  = jobCardProvider.allEmployees[pos];
                        return CheckboxListTile(
                          value: newTaskProvider.checkTechicianExists(technician),
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
                                  'Mobile No :' +technician.mobile,
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
                          onChanged: (val){
                            if(val){
                              newTaskProvider.addToSelectedEmployees(technician);
                            }else{
                              newTaskProvider.removeFromSelectedEmployees(technician);
                            }
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: jobCardProvider.allEmployees.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
                SizedBox(height: LINE_HEIGHT,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: PRIMARY_COLOR,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(32)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: APP_WHITE_COLOR,
                              size: ICON_SIZE*0.7,
                            ),
                            Text('| Close',
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
          );
        });
  }

}
