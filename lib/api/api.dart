import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' ;
import  '../model/RespObj.dart';


class ApiUtils {

  static ApiUtils _instance  = new ApiUtils.internal();
  ApiUtils.internal();

  factory ApiUtils() => _instance;
  static final baseUrl = "http://13.234.53.184/testmobappapis/api/test/";

  Future<RespObj> getData(String route,{String header}) async{
    Map<String, String> mHeaders = {"Content-type": "application/json","x-auth-token":header};
    try{
      Response response = await get(baseUrl+route,headers: mHeaders);
      print(json.decode(response.body));
      if(response.statusCode==200){
        print(json.decode(response.body));
        return RespObj(true,data: jsonDecode(response.body));
      }else{
        return RespObj(false,msg: response.body);
      }
    }catch(ex){
      print("Exception e :"+ex.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }

  }

  Future<RespObj> postData(String route,{String mBody,String header}) async{
    Map<String, String> mHeaders = {"Content-Type": "application/json","x-auth-token":header};
    try{
    Response response = await post(baseUrl+route,headers: mHeaders,body: mBody);
    if(response.statusCode==200){
      return RespObj.fromJSON(json.decode(response.body));
    }else{
      return RespObj(false,msg: response.body);
    }
    }catch(e){
      print(e.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }
  }

  Future<RespObj> fileUpload(String route,File file, String fileName,{String header,String id}) async{
    
    var request = MultipartRequest("POST", Uri.parse(baseUrl+route));
    request.fields["id"] = id;
    var image = await MultipartFile.fromPath(fileName, file.path);
    request.files.add(image);

    var resp = await request.send();
    var responseData = await resp.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return RespObj.fromJSON(json.decode(responseString));

  }

}

final api = ApiUtils();