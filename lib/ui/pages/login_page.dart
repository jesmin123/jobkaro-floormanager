import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/LoaderUtils.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of(context);

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
                child: Container(
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
                                mobNo: _mobNoController.text, password: _passwordController.text);
                            if (response.getStatus()) {
                              Loader.getLoader(context).show();
                              Future.delayed(Duration(seconds: 3)).then((value) {
                                Loader.getLoader(context).hide().whenComplete(() {
                                  Navigator.pushNamed(context, HOME_PAGE);
                                });
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Mobile No. or Password is Wrong',
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
                ),
              )
            ])));
  }
}
