import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier{

  bool _passwordToggle = false;
  bool get passwordToggle => _passwordToggle;

  set passwordToggle(bool value) {
    _passwordToggle = value;
    notifyListeners();
  }





  Future<RespObj> login(String mobNo,String password) async {
    String route = '';
    Map<String,dynamic> sendData = {
      "function":"login",
      "mobile":"$mobNo",
      "password":"$password"
    };

    String jsonData = jsonEncode(sendData);

    RespObj response = await api.postData(route, mBody: jsonData);
    if(response.getStatus()){
      dynamic data = response.data;
      user = UserModel.fromJSON(data['user_data']);
      print(user.name);
    }
    return response;
  }

  UserModel _user;

  UserModel get user => _user;

  set user(UserModel value) {
    _user = value;
    notifyListeners();
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

