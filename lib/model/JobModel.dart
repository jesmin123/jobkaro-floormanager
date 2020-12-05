
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

}