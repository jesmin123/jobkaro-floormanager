class Employee{
   String name;
   String designation;
   int id;
   String mobNo;
   String imgUrl;

   Employee({this.name, this.designation, this.id, this.mobNo});

   factory Employee.fromJSON(Map<String,dynamic> json){
     try{
       return Employee(name: json['name'],);
     }catch(ex){
       print(ex.toString());
       return null;
     }
   }

}