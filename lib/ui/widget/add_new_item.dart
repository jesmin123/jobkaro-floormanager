


import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';


class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {

  final _formKey = GlobalKey<FormState>();
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
                Text("Vehicle Details", style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),),
              SizedBox(height: 8,),
              ],
            )  ,
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText:"Model and Make",
                focusColor: APP_BLACK_COLOR
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),

            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(

                labelText: "Reg No."
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),

            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Customer Name"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(
                labelText:  "Customer Contact"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(
                labelText: "DMS Job Card Number"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'ERP Job Card Number'
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,),
              child: RaisedButton(
               onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushNamed(context, HOME_PAGE);
                  }
                  },
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(16)),
                color: PRIMARY_COLOR,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Submit', style: AppFontStyle.labelTextStyle2(APP_WHITE_COLOR),),
                ),


                  ),

              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      ListTile(leading:  Text('Team',style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR)),trailing: Text('0 members'),),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 32.0,),
                            child: Column(children: [
                              CircleAvatar(backgroundColor: PRIMARY_COLOR,radius: 45, child: Icon(Icons.person_add,color: APP_WHITE_COLOR,size: 35,),)
                              ,
                              Text('Add new',style: AppFontStyle.titleAppBarStyle(APP_BLACK_COLOR),),
                            ],
                            ),
                          ),
                        ],
                      ),
                    ListTile(leading: Text('Tasks',style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),),
                      trailing: InkWell(
                        onTap: (){
                          return showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc){
                                return Container(
                                  child: new Wrap(
                                    children: <Widget>[
                                      new ListTile(
                                          leading: new Icon(Icons.music_note),
                                          title: new Text('Music'),
                                          onTap: () => {}
                                      ),
                                      new ListTile(
                                        leading: new Icon(Icons.videocam),
                                        title: new Text('Video'),
                                        onTap: () => {},
                                      ),
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: PRIMARY_COLOR),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12,bottom: 6,top: 6),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: APP_WHITE_COLOR,size: 16,),
                                Text("Add task", style: AppFontStyle.labelTextStyle2(APP_WHITE_COLOR),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],


            )

          ],
        ),
      ),
    );
  }
}

