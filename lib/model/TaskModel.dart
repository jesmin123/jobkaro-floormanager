
import 'package:flutter/material.dart';

class TaskModel{
  int status;
  String name;
  String id;
  TimeOfDay elaspedTime;
  String minute;

  TaskModel({
      this.status, this.id, this.name, this.elaspedTime, this.minute,});

  factory TaskModel.fromJSON(Map<String, dynamic>json){
   try {
     return TaskModel(name: json['name'], minute: json['minute'], id: json['id']);
   }
   catch (ex) {
     debugPrint(ex.toString());
     return null;
   }
  }

}