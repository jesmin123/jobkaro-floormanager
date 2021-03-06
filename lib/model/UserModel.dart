
import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel{
  String id;
  String firstName;
  String lastName;
  String name;
  String mobile;
  String address;
  String branchId;
  String empCode;
  String gender;
  String role;
  String empId;
  String imgUrl;
  String loggedIn;
  String jwt;


  UserModel({
      this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.mobile,
      this.address,
      this.branchId,
      this.empCode,
      this.gender,
      this.role,
      this.empId,
      this.imgUrl,
      this.loggedIn,
      this.jwt
  });

  void splitNames(String name){
    this.firstName = name.split(" ")[0];
    this.lastName = name.split(" ")[1];
  }

  String getFullName(){
      if(firstName==null)
        return "User";
      return firstName+lastName;
  }

  factory UserModel.fromJSON(Map<String,dynamic> json,){
    try{
      return UserModel(id: json['id'], branchId: json['branch_id'], name: json['name'],empCode: json['emp_code'],gender: json['gender'],mobile: json['mobile'],address: json['address'],jwt: json['Jwt']);
    }catch(ex){
      debugPrint(ex.toString());
      return null;
    }
  }

  static fetchFromDummy(){
    String json = "{'firstName':'User','lastName':'Popular','empId':'SAM123','mobNo':'987654321'}";
    return jsonDecode(json);
  }

}