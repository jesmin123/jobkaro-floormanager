
import 'package:job_karo_floor_manager/model/JobModel.dart';

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
      this.jobModel});

  factory ServiceRequestModel.fromJSON(Map<String,dynamic> json){
    try{
      List<dynamic>  jobJson = json['tasks'];
      List<JobModel> jobModelTemp = new List();
      jobJson.forEach((element) {
        jobModelTemp.add(JobModel.fromJSON(element));
      });
      return ServiceRequestModel(
          status: json['status'],id: json['id'],customerName: json['customer_name'],
          customerContact: json['contact_number'],regNo: json['reg_no'],make: json['make'],
        model:  json['model'],timeofCompletion: json['time_of_completion'],timeofCreation: json['time_of_creation'],
        jobModel: jobModelTemp
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }
}