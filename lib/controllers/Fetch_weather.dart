import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/api/api_key.dart';
import 'package:http/http.dart' as http;
class Baseclient extends GetxController{
  var client=http.Client();
  Future <dynamic> getcondition(String cityname) async{
    try{
     var url=Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$api");
     var response= await client.get(url);
     if(response.statusCode==200){
      return jsonDecode(response.body)["weather"][0]["main"];
     }
     else{
       return null;
     }
    }
    on SocketException catch(e){
         print(e);
    }
  }
  Future <dynamic> gettemp(String cityname) async{
    try{
     var url=Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$api");
     var response= await client.get(url);
     if(response.statusCode==200){
      return jsonDecode(response.body)["main"]["temp"];
     }
     else{
       return null;
     }
    }
    on SocketException catch(e){
        print(e);
    }
  }
  Future <dynamic> gethumidity(String cityname) async{
    try{
     var url=Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$api");
     var response= await client.get(url);
     if(response.statusCode==200){
      return jsonDecode(response.body)["main"]["humidity"];
     }
     else{
       return null;
     }
    }
    on SocketException catch(e){
      print(e);
    }
  }
  Future <dynamic> geticon(String cityname) async{
    try{
     var url=Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$api");
     var response= await client.get(url);
     if(response.statusCode==200){
      return jsonDecode(response.body)["weather"][0]["icon"];
     }
     else{
       return null;
     }
    }
    on SocketException catch(e){
      print(e);
    }
  }
}