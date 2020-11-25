import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier{


  bool _passwordToggle = false;

  bool get passwordToggle => _passwordToggle;

  set passwordToggle(bool value) {
    _passwordToggle = value;
    notifyListeners();
  }

  login(String mobNo,String password){
    String route = '';
    Map<String,dynamic> sendData = {
      "function":"login",
      "mobile":"$mobNo",
      "password":"$password"
    };

    String jsonData = jsonEncode(sendData);

    api.postData(route, mBody: jsonData).then((value){
      if(value.getStatus()){
        dynamic data = value.data;

      }
    });
  }

  logout(){
    String route ='';
    Map<String, dynamic> logoutData = {
      "function" : "logout"
    };
    String jsonData = jsonEncode(logoutData);

    api.postData(route, mBody: jsonData).then((value){
      if(value.getStatus()){
        dynamic data = value.data;
      }
    });

  }

}