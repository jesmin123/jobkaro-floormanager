
import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel{
  String firstName;
  String lastName;
  String mobNo;
  String role;
  String empId;
  String imgUrl;


  UserModel({this.firstName, this.lastName, this.mobNo, this.role, this.empId,
      this.imgUrl});

  void splitNames(String name){
    this.firstName = name.split(" ")[0];
    this.lastName = name.split(" ")[1];
  }

  String getFullName(){
      if(firstName==null)
        return "User";
      return firstName+lastName;
  }

  factory UserModel.fromJSON(Map<String,dynamic> json){
    try{
      return UserModel(firstName: json['firstName'],lastName: json['lastName'],empId: json['empId'],imgUrl: json['imgUrl'],mobNo: json['mobNo'],role: json['role'],);
    }catch(ex){
      debugPrint(ex.toString());
      Map<String,dynamic> json = fetchFromDummy();
      return UserModel(firstName: json['firstName'],lastName: json['lastName'],empId: json['empId'],imgUrl: json['imgUrl'],mobNo: json['mobNo'],role: json['role'],);

    }
  }

  static fetchFromDummy(){
    String json = "{'firstName':'User','lastName':'Popular','empId':'SAM123','mobNo':'987654321'}";
    return jsonDecode(json);
  }

}