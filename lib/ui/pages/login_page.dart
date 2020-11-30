import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of(context);

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 4.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Exo"),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Exo"));

    return Scaffold(
        body: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/image 1.png'),
              SizedBox(
                height: LINE_HEIGHT,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your mobile number';
                        } else if (value.length != 10) {
                          return 'Please enter your valid mobile number';
                        }
                        return null;
                      },
                      controller: _mobNoController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        labelText: 'Mobile Number',
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
                    SizedBox(
                      height: LINE_HEIGHT * 0.5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: !userProvider.passwordToggle,
                      decoration: InputDecoration(
                        suffixIcon: userProvider.passwordToggle
                            ? IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  userProvider.passwordToggle = false;
                                })
                            : IconButton(
                                icon: Icon(Icons.visibility_off),
                                onPressed: () {
                                  userProvider.passwordToggle = true;
                                }),
                        labelText: PASSWORD,
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 0.5, color: PRIMARY_COLOR),
                        ),
                        errorBorder: OutlineInputBorder(
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
                    SizedBox(
                      height: LINE_HEIGHT * 0.5,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          RespObj response = await userProvider.login(
                              _mobNoController.text, _passwordController.text);
                          if (response.getStatus()) {
                            pr.show();
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              pr.hide().whenComplete(() {
                                Navigator.pushNamed(context, HOME_PAGE);
                              });
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: response.msg,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PRIMARY_COLOR,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            //TODO Provide message
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: PRIMARY_COLOR,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style:
                                AppFontStyle.labelTextStyle2(APP_WHITE_COLOR),
                          ),
                          Icon(
                            Icons.login_outlined,
                            color: APP_WHITE_COLOR,
                            size: ICON_SIZE * 0.6,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
