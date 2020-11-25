import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final _formKey = GlobalKey<FormState>();
  final singleValidator = MultiValidator([
    RequiredValidator(errorText: 'this field is required'),
  ]);

  @override
  Widget build(BuildContext context) {
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
              validator: singleValidator,
              decoration: InputDecoration(
                  labelText: "Model and Make", focusColor: APP_BLACK_COLOR),
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: "Reg No."),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: "Customer Name"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: "Customer Contact"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: "DMS Job Card Number"),
              validator: singleValidator,
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(labelText: 'ERP Job Card Number'),
              validator: singleValidator,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushNamed(context, HOME_PAGE);
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
            ListTile(
              leading: Text('Team',
                  style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR)),
              trailing: Text('0 members'),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                  ),
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
                        style: AppFontStyle.labelTextStyle2(APP_BLACK_COLOR),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Text(
                'Tasks',
                style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),
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
          ],
        ),
      ),
    );
  }
}
