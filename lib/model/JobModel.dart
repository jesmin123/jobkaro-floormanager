
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/model/TaskModel.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

class JobModel{
  String id;
  String startTime;
  String endTime;
  String pauseDuration;
  String taskDuration;
  String status;
  String overTime;
  TaskModel task;
  TeamModel techinican;

  JobModel({
      this.id,
      this.startTime,
      this.endTime,
      this.pauseDuration,
      this.taskDuration,
      this.status,
      this.overTime,
      this.task,
      this.techinican});

  factory JobModel.fromJSON(Map<String,dynamic> json){
      try{
        return JobModel(id: json['id'],status: json['status'],startTime: json['start_time'],
            endTime: json['end_time'],pauseDuration: json['pause_duration'],taskDuration: json['task_duration'],
            overTime: json['over_time'],task: TaskModel.fromJSON(json['job']),techinican: TeamModel.fromJSON(json['technician'])
        );
      }catch(ex){
        print(ex);
        return null;
      }
  }

  Color getLeadingColor(){
    if(status=="1"){
      return APP_GREY_COLOR;
    }else if(status == "2"){
      return PRIMARY_COLOR;
    }else if (status=="3"){
      return APP_GREEN_COLOR;
    }else{
      return APP_GREY_COLOR;
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
    }else if(startTime!=null && overTime=="1"){
      timetaken = task.minute;
    }
   else{
      timetaken = "00";
    }

    return timetaken;
  }

}