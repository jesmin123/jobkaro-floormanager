

import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

class OverTimeTaskModel{

  String id;
  String requestId;
  String startTime;
  String endTime;
  String pauseDuration;
  String status;
  String overTimeId;
  TeamModel technican;
  TaskModel job;
  ServiceRequestModel request;

  OverTimeTaskModel({
      this.id,
      this.requestId,
      this.startTime,
      this.endTime,
      this.pauseDuration,
      this.status,
      this.overTimeId,
      this.technican,
      this.job,
      this.request}
      );

  factory OverTimeTaskModel.fromJSON(Map<String,dynamic> json){
    try{

      TaskModel job  = TaskModel.fromJSON(json['job']);
      TeamModel technician = TeamModel.fromJSON(json['technician']);
      ServiceRequestModel serviceRequestModel = ServiceRequestModel.fromJSON(json['request']);
      
      return OverTimeTaskModel(id:  json['id'],status: json['status'],startTime: json['start_time'],
          endTime: json['end_time'],pauseDuration: json['pause_duration'],job: job,
          technican: technician,request: serviceRequestModel,overTimeId: json['over_time'],requestId: json['request_id']
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }

  String getTimeTaken(){
    String timetaken = "00";
    if(status=="1"){
      timetaken = "00";
    }
    else if(endTime!=null && startTime!=null){
      DateTime startTimeDt = DateTime.parse(startTime);
      DateTime endTimeDt = DateTime.parse(endTime);
      int pauseMin = 0;
      if(pauseDuration!=null){
        pauseMin = int.tryParse(pauseDuration);
      }
      int timeElapsed = endTimeDt.difference(startTimeDt).inMinutes;
      timetaken = (timeElapsed-pauseMin).toString();
    }
    else if(startTime!=null){
      DateTime startTimeDt = DateTime.parse(startTime);
      DateTime endTimeDt = DateTime.now();
      int pauseMin = 0;
      if(pauseDuration!=null){
        pauseMin = int.tryParse(pauseDuration);
      }
      int timeElapsed = endTimeDt.difference(startTimeDt).inMinutes;
      timetaken = (timeElapsed-pauseMin).abs().toString();
      print("Time of taken ::; ${ timetaken}");
    }else if(startTime!=null && overTimeId=="1"){
      timetaken = job.minute;
    }
    else{
      timetaken = "00";
    }

    return timetaken;
  }

}