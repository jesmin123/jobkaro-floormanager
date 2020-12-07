import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:job_karo_floor_manager/model/PauseTaskModel.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

import 'user_provider.dart';

class JobCardProvider extends ChangeNotifier{

  initData(UserProvider userProvider){
    getAllEmployes(userProvider.user.jwt);
    getAllTasks(userProvider.user.jwt);
    getAllPauseRequest(userProvider.user.jwt);
    getAllServiceRequests(userProvider.user.jwt);
  }

  List<TeamModel> _allEmployees = new List();

  List<TeamModel> get allEmployees => _allEmployees;

  set allEmployees(List<TeamModel> value) {
    _allEmployees = value;
    notifyListeners();
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

  TeamModel getTeamMember(String id){
    TeamModel member;
    allEmployees.forEach((element) {
      if(element.id == id){
        member = element;
      }
    });
    return member;
  }

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



  // --------------------------- Service Requests ------------------------------

  List<ServiceRequestModel> _serviceRequests = new List();

  List<ServiceRequestModel> get serviceRequests => _serviceRequests;

  set serviceRequests(List<ServiceRequestModel> value) {
    _serviceRequests = value;
    notifyListeners();
  }

  List<ServiceRequestModel> _completedServiceRequest = new List();

  List<ServiceRequestModel> get completedServiceRequest =>
      _completedServiceRequest;

  set completedServiceRequest(List<ServiceRequestModel> value) {
    _completedServiceRequest = value;
    notifyListeners();
  }

  getAllServiceRequests(String jwt){

    String route ='';
    Map<String, dynamic> sendData = {
      "function":"requests_list",
      "request_id":""
    };

    String jsonData = jsonEncode(sendData);

    api.postData(route, header: jwt,mBody: jsonData).then((value){
      List<ServiceRequestModel> serviceRequestsTemp = new List();
      List<ServiceRequestModel> finishedServiceRequestsTemp = new List();
      if(value.getStatus()){
        List<dynamic> jobCards = value.data['service_requests'];
        jobCards.forEach((element) {
          ServiceRequestModel service = ServiceRequestModel.fromJSON(element);
          if(service!=null){
            if(service.status=="3")
              finishedServiceRequestsTemp.add(service);
            else
              serviceRequestsTemp.add(service);
          }
        });
      }
      serviceRequests = serviceRequestsTemp;
      completedServiceRequest = finishedServiceRequestsTemp;
    });

  }

  Future<bool> markServiceAsCompleted(String jwt,String taskId) async {
    String route = '';
    Map<String, dynamic> sendData ={
      "function":"complete_request",
      "request_id":taskId
    };
    String jsonData = jsonEncode(sendData);
    RespObj response =  await api.postData(route, header: jwt,mBody: jsonData);
    if(response.getStatus()){
      getAllServiceRequests(jwt);
    }
    return response.getStatus();
  }

  //----------------------------------------------------------------------------

  ServiceRequestModel _selectedService;

  ServiceRequestModel get selectedService => _selectedService;

  set selectedService(ServiceRequestModel value) {
    _selectedService = value;
    notifyListeners();
  }


  // ------------------------Pause Request-------------------------
  List<PauseTaskModel> _pauseRequests = [];

  List<PauseTaskModel> get pauseRequests => _pauseRequests;

  set pauseRequests(List<PauseTaskModel> value) {
    _pauseRequests = value;
    notifyListeners();
  }

  getAllPauseRequest(String jwt) async{

    List<PauseTaskModel> pauseRequestsTemp = [];
    String route ='';
    Map<String, dynamic> sendData ={
      "function":"paused_tasks",
    };

    String jsonData = jsonEncode(sendData);

    api.postData(route, header: jwt,mBody: jsonData).then((value){
      if(value.getStatus()){
        List<dynamic> pausedTasks = value.data['paused_tasks'];
        pausedTasks.forEach((element) {
            pauseRequestsTemp.add(PauseTaskModel.fromJSON(element));
        });
      }
      pauseRequests = pauseRequestsTemp;
    });

  }

  Future<bool> pauseTask(String jwt,String taskId) async {
    String route = '';
    Map<String, dynamic> sendData ={
      "function":"pause_task",
      "task_id":taskId
    };
    String jsonData = jsonEncode(sendData);
    RespObj response =  await api.postData(route, header: jwt,mBody: jsonData);
    if(response.getStatus()){
      getAllPauseRequest(jwt);
    }
    return response.getStatus();
  }

  Future<bool> resumeTask(String jwt,String taskId) async {
    String route = '';
    Map<String, dynamic> sendData ={
      "function":"resume_task",
      "task_id":taskId
    };
    String jsonData = jsonEncode(sendData);
    RespObj response =  await api.postData(route, header: jwt,mBody: jsonData);
    if(response.getStatus()){
      getAllPauseRequest(jwt);
    }
    return response.getStatus();
  }

}


