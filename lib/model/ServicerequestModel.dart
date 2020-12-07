
import 'package:job_karo_floor_manager/model/JobModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

class ServiceRequestModel{
  String id;
  String model;
  String make;
  String regNo;
  String customerName;
  String customerContact;
  String timeofCreation;
  String timeofCompletion;
  String status;
  List<JobModel> jobModel = new List();
  List<TeamModel> assignedTechnicians = new List();

  ServiceRequestModel({
      this.id,
      this.model,
      this.make,
      this.regNo,
      this.customerName,
      this.customerContact,
      this.timeofCreation,
      this.timeofCompletion,
      this.status,
      this.jobModel,
  this.assignedTechnicians});

  factory ServiceRequestModel.fromJSON(Map<String,dynamic> json){
    try{
      List<dynamic>  jobJson = json['tasks'];
      List<JobModel> jobModelTemp = new List();
      jobJson.forEach((element) {
        jobModelTemp.add(JobModel.fromJSON(element));
      });

      List<dynamic> assignedJson = json['technicians'];
      List<TeamModel> assingedJsonTemp = new List();
      assignedJson.forEach((element) {
        assingedJsonTemp.add(TeamModel.fromJSON(element));
      });

      return ServiceRequestModel(
          status: json['status'],id: json['id'],customerName: json['customer_name'],
          customerContact: json['contact_number'],regNo: json['reg_no'],make: json['make'],
        model:  json['model'],timeofCompletion: json['time_of_completion'],timeofCreation: json['time_of_creation'],
        jobModel: jobModelTemp, assignedTechnicians: assingedJsonTemp
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }

 List<int> getProgressStatus(){
    int not_started = 0;
    int on_going = 0;
    int finished = 0;
    int deleted = 0;
    int pause_request = 0;
    int paused = 0;

    jobModel.forEach((element) {
      int status = int.parse(element.status);
      switch(status){
        case 1:
          not_started += 1;
          break;
        case 2:
          on_going += 1;
          break;
        case 3:
          finished += 1;
          break;
        case 4:
          deleted += 1;
          break;
        case 5:
          pause_request += 1;
          break;
        case 6:
          paused += 1;
          break;
      }
    });
    return [not_started,on_going,finished,deleted,pause_request,paused];
 }

 double getTaskCompletedPercent(){
    int completed_task_count = 0;
    jobModel.forEach((element) {
      int status = int.parse(element.status);
      if(status == 3){
        completed_task_count += 1;
      }
    });

    return completed_task_count/jobModel.length;
 }

  List<JobModel> getOnTimeTask(){
    List<JobModel> onTimeTaskList = [];
    jobModel.forEach((element) {
      if(element.overTime=="1"){
        onTimeTaskList.add(element);
      }
    });

    return onTimeTaskList;
  }

  List<JobModel> getOverTimeTask(){
    List<JobModel> overTimeTaskList = [];
    jobModel.forEach((element) {
      if(element.overTime=="2"){
        overTimeTaskList.add(element);
      }
    });

    return overTimeTaskList;
  }

}