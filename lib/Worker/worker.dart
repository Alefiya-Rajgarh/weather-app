import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class worker {
  late String location;

  worker({required this.location}) {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;

  Future<void> getData() async {
    try {
      Response resp = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=5de1ec7aa8c70846c51f705be037e317"));
      Map data = jsonDecode(resp.body);
      // getting temp humidity
      Map temp_data = data['main'];
      double gettemp = (temp_data['temp'] as num).toDouble() - 273.15;
      String gethumidity = temp_data['humidity'].toString();

      //description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain = weather_main_data['main'];
      String getdes = weather_main_data['description'].toString();

      //wind
      Map wind = data['wind'];
      double getairSpeed = wind['speed']/0.27777777777778;
      double getdeg = (wind['deg'] as num).toDouble();

      //assigning values
      temp = gettemp.toString(); //C
      humidity = gethumidity; //%
      airSpeed = getairSpeed.toString(); // km/hour
      description = getdes;
      main = getmain;
    }
    catch(e)
    {
      temp = "Can't Find Data";
      humidity = "Can't Find Data";
      airSpeed = "Can't Find Data";
      description ="Can't Find Data";
      main = "Can't Find Data";
    }
  }
}
