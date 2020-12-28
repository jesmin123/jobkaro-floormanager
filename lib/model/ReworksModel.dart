
import 'package:job_karo_floor_manager/model/ServicerequestModel.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

class ReworksModel{

  ReworkLogModel reworkLogModel;
  TeamModel technician;
  TaskModel job;
  ServiceRequestModel request;

  ReworksModel({this.reworkLogModel, this.technician, this.job, this.request});

  factory ReworksModel.fromJSON(Map<String,dynamic> json){
    try{
      ReworkLogModel reworkLogModel  = ReworkLogModel.fromJSON(json['rework']);
      ServiceRequestModel requestModel = ServiceRequestModel.fromJSON(json['request']);
      TaskModel taskModel =  TaskModel.fromJSON(json['job']);

      return ReworksModel(request: requestModel,job: taskModel,reworkLogModel: reworkLogModel);
    }catch(ex){
      print(ex);
      return null;
    }
  }


  String getTimeTaken(){

    reworkLogModel.pauseDuration = "0";
    String timetaken = "00";
    if(reworkLogModel.status=="1"){
      timetaken = "00";
    }
    else if(reworkLogModel.endTime!=null && reworkLogModel.startTime!=null){
      DateTime startTimeDt = DateTime.parse(reworkLogModel.startTime);
      DateTime endTimeDt = DateTime.parse(reworkLogModel.endTime);
      int pauseMin = 0;
      if(reworkLogModel.pauseDuration!=null){
        pauseMin = int.tryParse(reworkLogModel.pauseDuration);
      }
      int timeElapsed = endTimeDt.difference(startTimeDt).inMinutes;
      timetaken = (timeElapsed-pauseMin).toString();
    }
    else if(reworkLogModel.startTime!=null){
      DateTime startTimeDt = DateTime.parse(reworkLogModel.startTime);
      DateTime endTimeDt = DateTime.now();
      int pauseMin = 0;
      if(reworkLogModel.pauseDuration!=null){
        pauseMin = int.tryParse(reworkLogModel.pauseDuration);
      }
      int timeElapsed = endTimeDt.difference(startTimeDt).inMinutes;
      timetaken = (timeElapsed-pauseMin).abs().toString();
      print("Time of taken ::; ${ timetaken}");
    }else if(reworkLogModel.startTime!=null){
      timetaken = job.minute;
    }
    else{
      timetaken = "00";
    }

    return timetaken;
  }

}

class ReworkLogModel{
  String id;
  String requestId;
  String requestedTime;
  String pauseDuration;
  String startTime;
  String endTime;
  String status;


  ReworkLogModel({this.id, this.requestId, this.requestedTime, this.startTime,
      this.endTime, this.status});

  factory ReworkLogModel.fromJSON(Map<String,dynamic> json){
    try{
      return ReworkLogModel(
          id: json['id'],requestId: json['request_id'],startTime: json['start_time'],
        endTime: json['end_time'],status: json['status'],requestedTime: json['requested_time']
      );
    }catch(ex){
      print(ex);
      return null;
    }
  }

}