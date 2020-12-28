import 'package:flutter/cupertino.dart';

class TeamModel{
  String imgUrl;
  String name;
  String designation;
  String mobile;
  String gender;
  String id;
  String empCode;
  int synced = 0;

  TeamModel({this.imgUrl, this.name, this.designation, this.mobile, this.gender,
      this.id, this.empCode,this.synced});

  factory TeamModel.fromJSON(Map<String, dynamic>json){
    try{
      return TeamModel(name: json['name'],gender: json['gender'], mobile: json['mobile'], id: json['id'] ,synced: 0,empCode: json['emp_code']);
    }
    catch(ex){
      debugPrint(ex.toString());
      return null;
    }
  }



}