
import 'package:flutter/material.dart';

class TaskModel{
  int status;
  String task;
  String name;
  TimeOfDay elaspedTime;
  TimeOfDay allocatedTime;

  TaskModel(
      this.status, this.task, this.name, this.elaspedTime, this.allocatedTime);
}