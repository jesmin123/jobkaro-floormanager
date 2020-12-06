

import 'package:job_karo_floor_manager/model/TeamModel.dart';

class PauseTaskModel{
  String id;
  String requestID;
  String jobId;
  String startTime;
  String endTime;
  String pauseDuration;
  String taskDuration;
  String status;
  String pauseLogID;
  String overtime;
  PauseLogModel pauseLogModel;
  PauseItemModel pauseItemModel;
  TeamModel technician;

  PauseTaskModel({
      this.id,
      this.requestID,
      this.jobId,
      this.startTime,
      this.endTime,
      this.pauseDuration,
      this.taskDuration,
      this.status,
      this.pauseLogID,
      this.overtime,
      this.pauseLogModel,
    this.pauseItemModel,
    this.technician
  });

  factory PauseTaskModel.fromJSON(Map<String,dynamic> json){
    try{
      PauseLogModel pauseLogModel = PauseLogModel.fromJSON(json["pause_log"]);
      PauseItemModel pauseItemModel = PauseItemModel.fromJSON(json['request']);
      TeamModel teamModel= TeamModel.fromJSON(json['technician']);
      return PauseTaskModel(
        startTime: json['start_time'],id: json['id'],status: json['status'],
        taskDuration: json['task_duration'],pauseDuration: json['pause_duration'],
        endTime: json['end_time'],jobId: json['job_id'],overtime: json['over_time'],
        pauseLogID: json['pause_log_id'],pauseLogModel: pauseLogModel,requestID: json['request_id'],
        pauseItemModel: pauseItemModel,technician: teamModel
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }
}

class PauseLogModel{
  String requestedTime;
  String duration;
  String startTime;
  String endTIme;
  String reason;


  PauseLogModel({this.requestedTime, this.duration, this.startTime, this.endTIme,
      this.reason});

  factory PauseLogModel.fromJSON(Map<String,dynamic> json){
    try{
        return PauseLogModel(startTime: json['start_time'],duration: json['duration'],endTIme: json['end_time'],reason: json['reason'],requestedTime: json['requested_time']);
    }catch(ex){
      print(ex);
      return null;
    }
  }

}

class PauseItemModel{
  String id;
  String model;
  String make;
  String regNo;
  String customername;
  String customerNumber;

  PauseItemModel({this.id, this.model, this.make, this.regNo, this.customername,
      this.customerNumber});

  factory PauseItemModel.fromJSON(Map<String,dynamic> json){
    try{
      return PauseItemModel(
        id: json['id'],model: json['model'],make: json['make'],regNo: json['reg_no'],
        customername: json['customer_name'],customerNumber: json['contact_number']
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }
}