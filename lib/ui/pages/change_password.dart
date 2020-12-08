import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _conformPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: APP_WHITE_COLOR,), onPressed: (){Navigator.pop(context);}),
        title: Text(CHANGE_PASSWORD, style: AppFontStyle.headingTextStyle(APP_WHITE_COLOR, textSize: 20.0),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/image 2.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    TextFormField(
                      controller: _oldPasswordController,
                      validator: (value){
                        if(value.isEmpty){
                          return 'Enter your old password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                          labelText: OLD_PASSWORD,
                        labelStyle: TextStyle(fontFamily: 'Exo',fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(width: 0.5, color: PRIMARY_COLOR),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(width: 0.5, color: PRIMARY_COLOR),
                          ),
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                    ),
                    SizedBox(height: LINE_HEIGHT*0.8,),
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return 'Enter a new password';
                        }
                        else if(value.length<=5){
                          return 'Password must be at least 5 characters';
                        }
                        return null;
                      },
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                        labelText: NEW_PASSWORD,
                        labelStyle: TextStyle(fontFamily: 'Exo',fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: LINE_HEIGHT*0.8,),
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return 'Enter your new password';
                        }
                        else if(value!=_newPasswordController.text){
                          return 'Password doesnt match';
                        }
                        return null;
                      },
                      controller: _conformPasswordController,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: APP_RED_COLOR),
                        ),
                        labelText: CONFORM_PASSWORD,
                        labelStyle: TextStyle(fontFamily: 'Exo',fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: LINE_HEIGHT,),
                    RaisedButton(
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          bool response = await userProvider.changePassword(_conformPasswordController.text) ;
                          if(response){
                           showDialogBox();
                          }

                        }
                      },
                      color: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      child: Text(CHANGE_PASSWORD,style: AppFontStyle.headingTextStyle(APP_WHITE_COLOR, textSize: 16.0),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  showDialogBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Text("Password Updated Successfull",
                  style: AppFontStyle.headingTextStyle(
                      APP_BLACK_COLOR),
                ),
                SizedBox(height: LINE_HEIGHT * 0.5),
                Text(
                  "Are you want to Logout",
                  style: AppFontStyle.labelTextStyle(
                      APP_BLACK_COLOR),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                SizedBox(height: LINE_HEIGHT * 0.2),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HOME_PAGE);
                      },
                      child: Text(
                        "No",
                        style:
                        AppFontStyle.headingTextStyle(
                            PRIMARY_COLOR, textSize: 16.0),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          {
                            CircularProgressIndicator(

                            );
                            Navigator.pushNamed(
                                context, LOGIN_PAGE);
                          };
                        },
                        child: Text("Yes",
                            style: AppFontStyle
                                .headingTextStyle(
                                PRIMARY_COLOR, textSize: 16.0)))
                  ],
                )
              ],
            ),
          );
        }
    );
  }

}
