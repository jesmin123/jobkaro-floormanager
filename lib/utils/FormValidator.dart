import 'package:validated/validated.dart' as validate;

class FormValidator{

  static validateName(String name){
   return name!=null?name.length>3?null:"Invalid name":"Please enter name";
  }

  static validateFullName(String name){
   return  name!=null?name.length>3?name.split(" ").length>1?null:"Enter full name":"Invalid name":"Please enter name";
  }

  static validateEmail(String email){
    return email!=null?validate.isEmail(email)?null:"Invalid email":"Please enter email";
  }

  static validatePhone(String mobile){
    return mobile!=null?[10,12].contains(mobile.length)?null:"Invalid phone":"Please enter phone no";
  }

}