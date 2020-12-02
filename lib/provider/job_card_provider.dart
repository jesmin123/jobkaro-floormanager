import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

import 'user_provider.dart';

class JobCardProvider extends ChangeNotifier{

  List<TeamModel> _allEmployees = new List();

  List<TeamModel> get allEmployees => _allEmployees;

  set allEmployees(List<TeamModel> value) {
    _allEmployees = value;
    notifyListeners();
  }

  initData(UserProvider userProvider){
    getAllEmployes(userProvider.user.jwt);
    getAllTasks(userProvider.user.jwt);
  }

   getAllEmployes(String token) async {
    String route = '';
    Map<String, dynamic> sendData ={
      'function' : 'technicians_list'
    };

    List<TeamModel> allEmployeesTemp = new List();

    String jsonData = jsonEncode(sendData);
    api.postData(route, mBody: jsonData,header: token).then((value){
      if(value.getStatus()){
        List<dynamic> techies = value.data['technicians'];
        techies.forEach((element) {
          allEmployeesTemp.add(TeamModel.fromJSON(element));
        });
      }
      allEmployees = allEmployeesTemp;
    });

  }


  String selectedTask;

  List<TaskModel> _allTasks = new List();

  List<TaskModel> get allTasks => _allTasks;

  set allTasks(List<TaskModel> value) {
    _allTasks = value;
    notifyListeners();
  }

   getAllTasks(String jwt) async{
    String route ='';
    Map<String, dynamic> sendData ={
      'function' : 'tasks_list'
    };
    List<TaskModel> allTasksTemp = new List();
    String jsonData = jsonEncode(sendData);
    api.postData(route, header: jwt,mBody: jsonData).then((value){
      if(value.getStatus()){
        List<dynamic> tasks = value.data['tasks'];
        tasks.forEach((element) {
          allTasksTemp.add(TaskModel.fromJSON(element));
        });
      }
      allTasks =allTasksTemp;
    });
   }


}