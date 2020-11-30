import 'package:flutter/cupertino.dart';

class TeamModel{
  String imgUrl;
  String name;
  String designation;
  String mobile;
  String gender;
  String id;
  String empCode;

  TeamModel({this.imgUrl, this.name, this.designation, this.mobile, this.gender,
      this.id, this.empCode});

  factory TeamModel.fromJSON(Map<String, dynamic>json){
    try{
      return TeamModel(name: json['name'],gender: json['gender'], mobile: json['mobile'], id: json['id'] ,empCode: json['emp_code']);
    }
    catch(ex){
      debugPrint(ex.toString());
      return null;
    }
  }



}