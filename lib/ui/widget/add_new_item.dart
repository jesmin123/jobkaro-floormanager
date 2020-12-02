import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _isChecked = true;
  void _isCheckedChanged(bool value) => setState(() => _isChecked = value);

  final _formKey = GlobalKey<FormState>();
  final singleValidator = MultiValidator([
    RequiredValidator(errorText: 'this field is required'),
  ]);

  get checkboxValue => null;

  @override
  Widget build(BuildContext context) {
    final JobCardProvider jobCardProvider = Provider.of(context);
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
              trailing: Text('0 members'),
            ),
            Container(
              height: 100,
              child: ListView.separated(
                separatorBuilder: (_, pos) => SizedBox(
                  width: 8,
                ),
                shrinkWrap: true,
                itemCount: 6,
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
                              showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      content: Stack(
                                        children: [
                                          ListView.builder(
                                            itemBuilder: (context, pos) {
                                              return ListTile(
                                                trailing: Checkbox(
                                                    value: _isChecked,
                                                    onChanged:
                                                        _isCheckedChanged),
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
                                                          jobCardProvider
                                                              .allEmployees[pos]
                                                              .empCode,
                                                      style: AppFontStyle
                                                          .labelTextStyle4(
                                                              APP_BLACK_COLOR),
                                                    ),
                                                    Text(
                                                        'Mobile No :' +
                                                            jobCardProvider
                                                                .allEmployees[
                                                                    pos]
                                                                .mobile,
                                                        style: AppFontStyle
                                                            .labelTextStyle4(
                                                                APP_BLACK_COLOR)),
                                                  ],
                                                ),
                                                title: Text(
                                                  jobCardProvider
                                                      .allEmployees[pos].name,
                                                  style: AppFontStyle
                                                      .headingTextStyle(
                                                          APP_BLACK_COLOR,
                                                          textSize: 16.0),
                                                ),
                                              );
                                            },
                                            shrinkWrap: true,
                                            itemCount: jobCardProvider
                                                .allEmployees.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
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
                  } else
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              'https://www.adbasis.com/images/divita-a65623c8.jpg'),
                          radius: 32,
                        ),
                        Text(
                          'Arun Nair',
                          style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),
                        ),
                        Text(
                          'Technician',
                          style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),
                        )
                      ],
                    );
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
                  showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            width: MediaQuery.of(context).size.width,
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
                                  DropdownButtonFormField(
                                    hint: Text('Enter task'),
                                    items: jobCardProvider.allTasks.map((e) {
                                      return DropdownMenuItem(
                                        child: Text(e.name),
                                        value: e.id,
                                      );
                                    }).toList(),
                                    onChanged: (e) {
                                      jobCardProvider.selectedTask = e;
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
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
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('10.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('15.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('20.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('25.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          splashColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('30.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('35.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('40.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('45.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('50.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                        SizedBox(
                                          width: LINE_HEIGHT * 0.5,
                                        ),
                                        RaisedButton(
                                          onPressed: () {},
                                          splashColor: PRIMARY_COLOR,
                                          highlightColor: PRIMARY_COLOR,
                                          elevation: 0,
                                          focusColor: PRIMARY_COLOR,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              side: BorderSide(
                                                  color: APP_BLACK_COLOR)),
                                          child: Text('55.00 m',
                                              style:
                                                  AppFontStyle.labelTextStyle2(
                                                      APP_BLACK_COLOR)),
                                        ),
                                      ],
                                    ),
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
                                          onPressed: () {},
                                          color: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.done,
                                                color: APP_WHITE_COLOR,
                                              ),
                                              Text('Save',
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
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    RespObj response = await jobCardProvider.CreateRequest(
                        _modelController.text,
                        _makeController.text,
                        _regNoController.text,
                        _customerNameController.text,
                        _customerContactController.text);
                    if (response.getStatus()) {
                      Fluttertoast.showToast(
                        msg: response.msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: PRIMARY_COLOR,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Something wrong",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: PRIMARY_COLOR,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
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
}
