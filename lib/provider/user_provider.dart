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

  Future<RespObj> login({String mobNo,String password}) async {
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
      saveLoginLocal(jsonEncode(data['user_data']));
      print(user.name);
    }
    return response;
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  UserModel _user;

  UserModel get user => _user;

  set user(UserModel value) {
    _user = value;
    notifyListeners();
  }

  logout(){
    isLoggedIn = false;
    String route ='';
    Map<String, dynamic> logoutData = {
      "function" : "logout"
    };
    String jsonData = jsonEncode(logoutData);
    saveLoginLocal(null);
    api.postData(route, mBody: jsonData,header: user.jwt).then((value){
      if(value.getStatus()){
        //todo implement logic here
      }
    });

  }

  Future<void> saveLoginLocal(String userData) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('login-timestamp', DateTime.now().toString());
    sh.setString("user", userData);
  }

  Future<bool> checkLoginLocal() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String loginDtTimestamp =  sh.getString('login-timestamp',);

    String userString = sh.getString("user");
    if(userString==null){
      return false;
    }
    UserModel userTemp = UserModel.fromJSON(jsonDecode(userString));
    if(userTemp==null){
      return false;
    }

    user = userTemp;
    isLoggedIn = true;
    if(loginDtTimestamp!=null){
      DateTime dateTimeLogin = DateTime.parse(loginDtTimestamp);
      int hrsElpased = DateTime.now().difference(dateTimeLogin).inHours;
      if(hrsElpased<20){
        return true;
      }
      else{
        logout();
        return false;
      }
    }
    return true;



  }


 Future<bool> changePassword(String newPassword) async {
    String route ='';
    Map<String, dynamic> sendData = {
      "function":"change_password",
      "password":"$newPassword"
    };

    String jsonData = jsonEncode(sendData);
    RespObj response = await api.postData(route, mBody: jsonData, header: user.jwt);
    return response.getStatus();

 }




}

