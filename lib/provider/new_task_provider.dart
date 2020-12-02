
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';

class NewtaskProvider extends ChangeNotifier {
  List<TeamModel> _selectedEmployees = new List();
  List<TaskModel> _selectedTask = new List();

  List<TeamModel> get selectedEmployees => _selectedEmployees;

  set selectedEmployees(List<TeamModel> value) {
    _selectedEmployees = value;
    notifyListeners();
  }

  List<TaskModel> get selectedTask => _selectedTask;

  set selectedTask(List<TaskModel> value) {
    _selectedTask = value;
    notifyListeners();
  }

  addToSelectedEmployees(TeamModel technician){
    bool status = checkTechicianExists(technician);
    if(status){
      return;
    }
    List<TeamModel> selectedEmployeesTemp = selectedEmployees;
    selectedEmployeesTemp.add(technician);
    selectedEmployees = selectedEmployeesTemp;
  }

  bool checkTechicianExists(TeamModel technician){
    bool status = false;
    status = selectedEmployees.contains(technician);
    return status;
  }

  removeFromSelectedEmployees(TeamModel technician){
    List<TeamModel> selectedEmployeesTemp = selectedEmployees;
    selectedEmployeesTemp.removeWhere((element) => element == technician);
    selectedEmployees = selectedEmployeesTemp;
  }

  addToSelectedTask(TaskModel task){
    List<TaskModel> selectedTaskTemp = selectedTask;
    selectedTaskTemp.add(task);
    selectedTask = selectedTaskTemp;
  }

  bool checkTaskExists(TaskModel task){
    bool status = false;
    status = selectedTask.contains(task);
    return status;
  }

  removeFromSelectedTask(TaskModel task){
    List<TaskModel> selectedTaskTemp = selectedTask;
    selectedTaskTemp.removeWhere((element) => element==task);
    selectedTask = selectedTaskTemp;
  }

  Future <RespObj> CreateRequest(String model, String make, String regNo, String customerName, String customerContact,UserProvider userProvider)async {
    String route = '';

    List<Map> tasks = [];
    _selectedTask.forEach((element) {
      tasks.add({'job_id':element.id});
    });

    List<Map> technicians = [];
    _selectedEmployees.forEach((element) {
      technicians.add({'technician_id':element.id});
    });

    Map<String, dynamic> createRequest = {
      "function": "create_request",
      "model": "$model",
      "make": "$make",
      "reg_no": "$regNo",
      "customer_name": "$customerName",
      "contact_number": "$customerContact",
      'user_id':userProvider.user.id,
      "access_token":"3T97X",
      'tasks':tasks,
      'technicians':technicians
    };
    String jsonData = jsonEncode(createRequest);

    api.postData(route, mBody: jsonData,header: userProvider.user.jwt).then((value) {
      if (value.getStatus()) {
        dynamic data = value.data;
        //TODO Clear all the existing data
      }
    });
  }

}