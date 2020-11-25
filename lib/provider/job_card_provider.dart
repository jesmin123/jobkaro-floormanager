import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/model/EmployeeModel.dart';

class JobCardProvider extends ChangeNotifier{

  List<Employee> allEmployees = new List();


  initData(){
    fetchDummy();
  }

  void fetchDummy() {
    allEmployees.add(Employee(name: "Biby Chacko",designation: "Technican"));
    allEmployees.add(Employee(name: "Anoop  John",designation: "Technican"));
    allEmployees.add(Employee(name: "Aby Chacko",designation: "Technican"));
    allEmployees.add(Employee(name: "Akash prasad",designation: "Technican"));
    allEmployees.add(Employee(name: "Anu Prakash",designation: "Technican"));
  }

}