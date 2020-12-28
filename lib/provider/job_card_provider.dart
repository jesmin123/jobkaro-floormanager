import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/api/api.dart';
import 'package:job_karo_floor_manager/model/JobModel.dart';
import 'package:job_karo_floor_manager/model/OverTimetaskModel.dart';
import 'package:job_karo_floor_manager/model/PauseTaskModel.dart';
import 'package:job_karo_floor_manager/model/RespObj.dart';
import 'package:job_karo_floor_manager/model/ReworksModel.dart';
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
    getOverTimeJobs(userProvider.user.jwt);
    getReworkTasks(userProvider.user.jwt);
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

  updateSelectedService(String jwt) async {

    String route = '';

    List<Map> tasks = [];
    _selectedService.jobModel.forEach((element) {
      if(element.synced==-1)
        tasks.add({'job_id':element.task.id});
    });

    List<Map> technicians = [];
    _selectedService.assignedTechnicians.forEach((element) {
      if(element.synced==-1)
        technicians.add({'technician_id':element.id});
    });

    Map sendData =
      {
        "function":"edit_request",
        "request_id": selectedService.id,
        "model": selectedService.model,
        "make": selectedService.make,
        "reg_no": selectedService.regNo,
        "customer_name": selectedService.customerName,
        "contact_number":selectedService.customerContact,
        "dms":selectedService.dms,
        "erp":selectedService.erp,
        "comment":selectedService.comment,
        "tasks":tasks,
        "technicians": technicians,
    };

    String jsonData = jsonEncode(sendData);

    RespObj response = await api.postData(route, mBody: jsonData,header: jwt);
    return response;

  }

  updateServiceJobs(String jwt,List<TaskModel> tasks) async {

    String route = '';
    List<Map> newTasks = [];
    tasks.forEach((element) {
        if(element.selected){
          selectedService.jobModel.add(JobModel(id: "-1",endTime: null,pauseDuration: null,startTime: null,taskDuration: element.minute,status: "0",task: element,overTime: "0",synced: -1,techinican: null));
          newTasks.add({'job_id':element.id});
      }

    });

    List<Map> technicians = [];
    _selectedService.assignedTechnicians.forEach((element) {
      if(element.synced==-1)
        technicians.add({'technician_id':element.id});
    });

    Map sendData =
    {
      "function":"edit_request",
      "request_id": selectedService.id,
      "model": selectedService.model,
      "make": selectedService.make,
      "reg_no": selectedService.regNo,
      "customer_name": selectedService.customerName,
      "contact_number":selectedService.customerContact,
      "dms":selectedService.dms,
      "erp":selectedService.erp,
      "comment":selectedService.comment,
      "tasks":newTasks,
      "technicians": technicians,
    };

    String jsonData = jsonEncode(sendData);

    RespObj response = await api.postData(route, mBody: jsonData,header: jwt);
    return response;

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
          PauseTaskModel model = PauseTaskModel.fromJSON(element);
          if(model!=null){
            pauseRequestsTemp.add(model);
          }

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

  List<OverTimeTaskModel> _overtimeTasks = [];


  List<OverTimeTaskModel> get overtimeTasks => _overtimeTasks;

  set overtimeTasks(List<OverTimeTaskModel> value) {
    _overtimeTasks = value;
    notifyListeners();
  }

  void getOverTimeJobs(String jwt) {

    String route ='';
    Map<String, dynamic> sendData ={
      'function' : 'over_time_tasks'
    };

    List<OverTimeTaskModel> overtimeTasksTemp = [];

    String jsonData = jsonEncode(sendData);
    api.postData(route, header: jwt,mBody: jsonData).then((value){
      if(value.getStatus()){
        List<dynamic> overtimeJobs = value.data['over_time_tasks'];
        overtimeJobs.forEach((element) {
          overtimeTasksTemp.add(OverTimeTaskModel.fromJSON(element));
        });
      }

      overtimeTasks = overtimeTasksTemp;

    });
  }


  Future<RespObj> addToReworkTasks(String jwt,String taskId) async {
    String route = "";

    Map sendData = {
      "function":"rework_task",
      "task_id":"$taskId"
    };

    String json = jsonEncode(sendData);
    RespObj respObj =  await api.postData(route,mBody: json,header: jwt);

    return respObj;
  }

  List<ReworksModel> _reworks = [];


  List<ReworksModel> get reworks => _reworks;

  set reworks(List<ReworksModel> value) {
    _reworks = value;
    notifyListeners();
  }

  void getReworkTasks(String jwt) {
    String route = '';
    Map sendData = {
      "function":"reworks"
    };

    String jsonData = jsonEncode(sendData);
    List<ReworksModel> reworksTemp = [];

    api.postData(route, header: jwt,mBody: jsonData).then((value){
      if(value.getStatus()){
        List<dynamic> overtimeJobs = value.data['reworks'];
        overtimeJobs.forEach((element) {
          reworksTemp.add(ReworksModel.fromJSON(element));
        });
      }

      reworks = reworksTemp;

    });
  }

}


